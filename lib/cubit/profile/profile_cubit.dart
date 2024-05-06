import 'dart:io';

import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/file/file_exceptions.dart';
import 'package:homelinker/services/file/file_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/profile/profile_states.dart';

@injectable
class ProfileCubit extends BaseCubit {
  ProfileCubit(this._fileService, this._userService) : super(InitialState());

  final FileService _fileService;
  final UserService _userService;

  Future<void> load() async {
    safeEmit(PendingState());

    Future.delayed(const Duration(milliseconds: 400), () => safeEmit(ProfilePageLoadedState()));
  }

  Future<void> changePicture() async {
    safeEmit(PendingState());

    try {
      final imagePath = await _fileService.pickImageFromGallery();
      File image = File(imagePath);
      final imageId = await _fileService.insertNewImage(image: image);
      await _userService.updateUser(imageId: imageId);

      safeEmit(ImageUploadedSuccessfullyState(image: image));
    } on NoFileChosenException {
      safeEmit(NoFileChosenState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
