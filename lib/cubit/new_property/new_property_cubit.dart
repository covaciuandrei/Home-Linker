import 'dart:io';

import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/new_property/new_property_states.dart';

@injectable
class NewPropertyCubit extends BaseCubit {
  NewPropertyCubit(
    this._propertyService,
    this._userService,
  ) : super(InitialState());
  final PropertyService _propertyService;
  final UserService _userService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 300), () => safeEmit(PageLoadedState()));
  }

  Future<File?> uploadImage() async {
    safeEmit(PendingState());

    Future.delayed(const Duration(milliseconds: 50),
        () => safeEmit(ImageUploadedSuccessfullyState()));
    return File('');
  }

  Future<void> addProperty({
    required int areaSize,
    required int bathrooms,
    required int bedrooms,
    required int constructionYear,
    required String description,
    required String imageLink,
    required String listingType,
    required String location,
    required int parkingSpaces,
    required double price,
    required String propertyType,
  }) async {
    safeEmit(PendingState());
    try {
      final user = await _userService.getLoggedUser();
      final property = Property(
        areaSize: areaSize,
        bathrooms: bathrooms,
        bedrooms: bedrooms,
        constructionYear: constructionYear,
        description: description,
        imageLink: imageLink,
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

      await Future.delayed(const Duration(seconds: 1));
      await _propertyService.addNewProperty(property: property);
      safeEmit(PropertyAddedSuccessfullyState());
    } catch (e) {
      safeEmit(SomethingWentWrongState());
      print(e);
    }
  }
}
