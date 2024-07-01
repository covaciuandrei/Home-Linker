import 'dart:io';

import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/services/app_version/app_version_service.dart';
import 'package:homelinker/services/file/file_exceptions.dart';
import 'package:homelinker/services/file/file_service.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/profile/profile_states.dart';

@injectable
class ProfileCubit extends BaseCubit {
  ProfileCubit(
    this._fileService,
    this._userService,
    this._imageService,
    this._appVersionService,
  ) : super(InitialState());

  final FileService _fileService;
  final UserService _userService;
  final ImageService _imageService;
  final AppVersionService _appVersionService;

  File? _profilePicture;

  Future<void> load() async {
    safeEmit(PendingState());
    final user = await _userService.getLoggedUser();
    final appVersion = await _appVersionService.get();

    if (user.profilePictureId.isEmpty) {
      _profilePicture = null;
    } else {
      _profilePicture = await _imageService.getImage(imageId: user.profilePictureId);
    }

    Future.delayed(const Duration(milliseconds: 200),
        () => safeEmit(ProfilePageLoadedState(profilePicture: _profilePicture, user: user, appVersion: appVersion)));
  }

  Future<void> changePicture() async {
    safeEmit(PendingState());

    try {
      final imagePath = await _fileService.pickImageFromGallery();
      File image = File(imagePath);
      final imageId = await _fileService.insertNewImage(image: image);

      if (_profilePicture != null) {
        final user = await _userService.getLoggedUser();
        await _imageService.delete(imageId: user.profilePictureId);
      }

      await _userService.updateUser(imageId: imageId);

      safeEmit(ImageUploadedSuccessfullyState(image: image));
    } on NoFileChosenException {
      safeEmit(NoFileChosenState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<void> deletePicture() async {
    safeEmit(PendingState());
    final user = await _userService.getLoggedUser();
    try {
      if (user.profilePictureId.isNotEmpty) {
        await _imageService.delete(imageId: user.profilePictureId);
        await _userService.updateUser(imageId: '');
      }

      safeEmit(ImageDeletedSuccessfullyState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
