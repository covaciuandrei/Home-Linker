part of 'package:homelinker/cubit/profile/profile_cubit.dart';

class ProfilePageLoadedState extends BaseState {
  ProfilePageLoadedState({
    required this.profilePicture,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
  });
  final File? profilePicture;
  final String email;
  final String phoneNumber;
  final String fullName;
}

class NoFileChosenState extends BaseState {}

class ImageDeletedSuccessfullyState extends BaseState {}

class ImageUploadedSuccessfullyState extends BaseState {
  ImageUploadedSuccessfullyState({required this.image});

  final File? image;
}
