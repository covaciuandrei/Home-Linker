import 'dart:collection';
import 'dart:io';

import 'package:homelinker/data/remote/image/image_source.dart';
import 'package:homelinker/data/remote/storage/storage_source.dart';
import 'package:homelinker/data/repository/image_repository.dart';
import 'package:homelinker/models/image.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImageService {
  ImageService(
    this._imageSource,
    this._storageSource,
    this._imageRepository,
  );

  final ImagesSource _imageSource;
  final StorageSource _storageSource;
  final ImageRepository _imageRepository;

  // In-memory LRU cache so repeated reads of the same image id within a
  // session avoid hitting Drift + re-writing bytes to a temp file every time.
  // Drift remains the persistent cache; this is just a hot-path optimization.
  static const int _maxMemoryCacheEntries = 50;
  static final LinkedHashMap<String, File> _memoryCache = LinkedHashMap<String, File>();

  static void _putInMemoryCache(String imageId, File file) {
    _memoryCache.remove(imageId);
    _memoryCache[imageId] = file;
    while (_memoryCache.length > _maxMemoryCacheEntries) {
      _memoryCache.remove(_memoryCache.keys.first);
    }
  }

  static File? _getFromMemoryCache(String imageId) {
    final cached = _memoryCache.remove(imageId);
    if (cached == null) return null;
    if (!cached.existsSync()) return null; // tmp file evicted by the OS
    _memoryCache[imageId] = cached; // bump to most-recently-used
    return cached;
  }

  static void _evictFromMemoryCache(String imageId) {
    _memoryCache.remove(imageId);
  }

  Future<File?> getImage({required String imageId}) async {
    if (imageId.isEmpty) {
      return null;
    }
    final cached = _getFromMemoryCache(imageId);
    if (cached != null) {
      return cached;
    }

    if (await _imageRepository.isExpired(additionalParam: 'image:$imageId')) {
      final Image imageFromSource = await _imageSource.get(imageId: imageId);
      final File? image = await _storageSource.downloadImage(
        imagePath: imageFromSource.path,
        name: '$imageId-${imageFromSource.name}',
      );
      await _imageRepository.clear(imageId: imageId);
      await _imageRepository.insert(
        imageData: imageFromSource,
        imageFile: image,
        imageId: imageId,
      );
      if (image != null) {
        _putInMemoryCache(imageId, image);
      }
      return image;
    }

    final fromDisk = await _imageRepository.getImage(imageId: imageId);
    _putInMemoryCache(imageId, fromDisk);
    return fromDisk;
  }

  Future<void> delete({required String imageId}) async {
    try {
      final image = await _imageSource.get(imageId: imageId);
      await _storageSource.deleteImage(path: image.path);
      await _imageSource.delete(imageId: imageId);
      await _imageRepository.clear(imageId: imageId);
      _evictFromMemoryCache(imageId);
    } on Exception {
      throw Exception();
    }
  }
}
