import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/place_location.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/file/file_exceptions.dart';
import 'package:homelinker/services/file/file_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

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
  double? lat;
  double? lng;

  Future<void> getCurrentLocation({LatLng? coordonate}) async {
    safeEmit(PendingState());

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    lat = locationData.latitude;
    lng = locationData.longitude;

    await Future.delayed(const Duration(seconds: 1));

    if (lat == null || lng == null) {
      return;
    }

    await getLocation(lat: lat!, lng: lng!);
  }

  Future<void> getSelectedLocation({required LatLng coordonate}) async {
    lat = coordonate.latitude;
    lng = coordonate.longitude;

    if (lat == null || lng == null) {
      return;
    }

    await getLocation(lat: lat!, lng: lng!);
  }

  Future<void> getLocation({required double lng, required double lat}) async {
    safeEmit(PendingState());

    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    if (apiKey == null) {
      safeEmit(SomethingWentWrongState());
      return;
    }
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');
    final response = await http.get(url);
    final resData = json.decode(response.body);

    String city = '';
    String country = '';

    final addressComponents = resData['results'][0]['address_components'];
    for (var component in addressComponents) {
      if (component['types'].contains('locality')) {
        city = component['long_name'];
      }
      if (component['types'].contains('country')) {
        country = component['long_name'];
      }
    }
    final address = '$city, $country';

    final location = PlaceLocation(latLng: LatLng(lat, lng), address: address);

    safeEmit(LocationPickedState(location: location));
  }

  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(const Duration(milliseconds: 100), () => safeEmit(PageLoadedState()));
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
        listingType: listingType == ListingType.rent.name ? ListingType.rent : ListingType.sale,
        location: location,
        ownerEmail: user.email,
        ownerName: user.name,
        parkingSpaces: parkingSpaces,
        price: price,
        propertyType: propertyType == PropertyType.apartment.name ? PropertyType.apartment : PropertyType.house,
      );

      await _propertyService.addNewProperty(property: property);

      safeEmit(PropertyAddedSuccessfullyState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
