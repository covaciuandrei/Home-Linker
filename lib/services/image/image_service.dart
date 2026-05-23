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

  Future<File?> getImage({required String imageId}) async {
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
      return image;
    }

    return _imageRepository.getImage(imageId: imageId);
  }

  Future<void> delete({required String imageId}) async {
    try {
      final image = await _imageSource.get(imageId: imageId);
      await _storageSource.deleteImage(path: image.path);
      await _imageSource.delete(imageId: imageId);
      await _imageRepository.clear(imageId: imageId);
    } on Exception {
      throw Exception();
    }
  }
}
