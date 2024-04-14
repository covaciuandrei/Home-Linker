import 'dart:io';

import 'package:homelinker/data/remote/image/image_source.dart';
import 'package:homelinker/data/remote/storage/storage_source.dart';
import 'package:homelinker/models/image.dart';
import 'package:homelinker/services/file/file_exceptions.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@injectable
class FileService {
  const FileService(
    this._storageSource,
    this._userService,
    this._imageSource,
  );

  final StorageSource _storageSource;
  final UserService _userService;
  final ImagesSource _imageSource;

  Future<String> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      // final bytes = await image.readAsBytes();
      return image.path;
    } else {
      print('no img chosen');
      throw NoFileChosenException();
    }
  }

  Future<String> insertNewImage({required File image}) async {
    final loggedUser = await _userService.getLoggedUser();

    final String imageName = basename(image.path);

    String imagesRemoteStoragePath =
        join('images', loggedUser.email, imageName);
    bool fileExists =
        await _storageSource.doesFileExist(imagesRemoteStoragePath);
    String finalFileName = imageName;
    int count = 1;

    while (fileExists) {
      final extension = imageName.split('.').last;
      final fullName =
          imageName.substring(0, imageName.length - extension.length - 1);
      finalFileName = '$fullName ($count).$extension';
      imagesRemoteStoragePath = join('images', loggedUser.email, finalFileName);
      fileExists = await _storageSource.doesFileExist(imagesRemoteStoragePath);
      count++;
    }

    await _storageSource.uploadFile(
      filePathRemote: imagesRemoteStoragePath,
      filePath: image.path,
    );

    final newImage = Image(
      name: finalFileName,
      path: imagesRemoteStoragePath,
      uploadDate: DateTime.now(),
    );

    final imageId = await _imageSource.insert(newImage);
    return imageId;
  }
}

