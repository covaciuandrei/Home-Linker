import 'dart:io';

import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/file/file_exceptions.dart';
import 'package:homelinker/services/file/file_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/new_property/new_property_states.dart';

@injectable
class NewPropertyCubit extends BaseCubit {
  NewPropertyCubit(
    this._propertyService,
    this._userService,
    this._fileService,
  ) : super(InitialState());
  final PropertyService _propertyService;
  final UserService _userService;
  final FileService _fileService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 300), () => safeEmit(PageLoadedState()));
  }

  Future<void> pickPicture() async {
    safeEmit(PendingState());

    try {
      final imagePath = await _fileService.pickImageFromGallery();
      File imageFile = File(imagePath);

      safeEmit(FileUploadedState(imageFile: imageFile));
    } on NoFileChosenException {
      safeEmit(NoFileChosenState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<String> uploadImage({required File image}) async {
    safeEmit(PendingState());
    try {
      final imageId = await _fileService.insertNewImage(image: image);

      await Future<void>.delayed(const Duration(milliseconds: 20));

      safeEmit(ImageUploadedSuccessfullyState());
      return imageId;
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
    return '';
  }

  Future<void> addProperty({
    required int areaSize,
    required int bathrooms,
    required int bedrooms,
    required int constructionYear,
    required String description,
    required File selectedImage,
    required String listingType,
    required String location,
    required int parkingSpaces,
    required double price,
    required String propertyType,
  }) async {
    safeEmit(PendingState());
    try {
      final user = await _userService.getLoggedUser();
      final imageId = await uploadImage(image: selectedImage);
      final property = Property(
        areaSize: areaSize,
        bathrooms: bathrooms,
        bedrooms: bedrooms,
        constructionYear: constructionYear,
        description: description,
        imageId: imageId,
        listingType: listingType == ListingType.rent.name
            ? ListingType.rent
            : ListingType.sale,
        location: location,
        ownerEmail: user.email,
        ownerName: user.name,
        parkingSpaces: parkingSpaces,
        price: price,
        propertyType: propertyType == PropertyType.apartment.name
            ? PropertyType.apartment
            : PropertyType.house,
      );

      await _propertyService.addNewProperty(property: property);

      safeEmit(PropertyAddedSuccessfullyState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
