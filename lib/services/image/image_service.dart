import 'dart:io';

import 'package:homelinker/data/remote/image/image_source.dart';
import 'package:homelinker/data/remote/storage/storage_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImageService {
  ImageService(this._imageSource, this._storageSource);

  final ImagesSource _imageSource;
  final StorageSource _storageSource;

  Future<File?> getImage({required String imageId}) async {
    final imageFromSource = await _imageSource.get(imageId: imageId);
    final image = _storageSource.downloadImage(
      imagePath: imageFromSource.path,
      name: imageFromSource.name,
    );
    return image;
  }

  Future<void> delete({required String imageId}) async {
    try {
      final image = await _imageSource.get(imageId: imageId);
      await _storageSource.deleteImage(path: image.path);
      await _imageSource.delete(imageId: imageId);
    } on Exception {
      throw Exception();
    }
  }
}
