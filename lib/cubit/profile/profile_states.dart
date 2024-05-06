part of 'package:homelinker/cubit/profile/profile_cubit.dart';

class ProfilePageLoadedState extends BaseState {
  ProfilePageLoadedState({
    required this.profilePicture,
    required this.user,
    required this.appVersion,
  });
  final File? profilePicture;
  final User user;
  final AppVersion appVersion;
}

class NoFileChosenState extends BaseState {}

class ImageDeletedSuccessfullyState extends BaseState {}

class ImageUploadedSuccessfullyState extends BaseState {
  ImageUploadedSuccessfullyState({required this.image});

  final File? image;
}
