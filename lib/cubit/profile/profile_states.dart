part of 'package:homelinker/cubit/profile/profile_cubit.dart';

class ProfilePageLoadedState extends BaseState {}

class NoFileChosenState extends BaseState {}

class ImageUploadedSuccessfullyState extends BaseState {
  ImageUploadedSuccessfullyState({required this.image});

  final File? image;
}
