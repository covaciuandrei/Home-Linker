part of 'package:homelinker/cubit/new_property/new_property_cubit.dart';

class ImageUploadedSuccessfullyState extends BaseState {}

class PageLoadedState extends BaseState {}

class PropertyAddedSuccessfullyState extends BaseState {}

class NoFileChosenState extends BaseState {}

class FileUploadedState extends BaseState {
  FileUploadedState({
    required this.imageFile,
  });
  final File? imageFile;
}
