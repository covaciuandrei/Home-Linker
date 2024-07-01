import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/data/database/database_provider.dart';
import 'package:homelinker/models/filters.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/home/home_states.dart';

@injectable
class HomeCubit extends BaseCubit {
  HomeCubit(
    this._propertyService,
    this._imageService,
    this._userService,
    this._databaseProvider,
  ) : super(InitialState());

  final PropertyService _propertyService;
  final ImageService _imageService;
  final UserService _userService;
  final DatabaseProvider _databaseProvider;

  List<Property> properties = [];
  List<Listing> listings = [];
  List<String> languages = [];
  RangeValues priceRange = const RangeValues(0, 100000);
  Future<void> deleteData() async {
    await _databaseProvider.get.clear();
  }

  Future<void> load({bool? forceRefresh}) async {
    safeEmit(PendingState());
    await Future.delayed(const Duration(milliseconds: 200));
    final user = await _userService.getLoggedUser();
    properties = await _propertyService.getAll(forceRefresh: forceRefresh);
    listings = [];

    for (final property in properties) {
      final image = await _imageService.getImage(imageId: property.imageId);
      listings.add(Listing(image: image!, property: property));
    }
    final maxPropertyPrice = getPropertyMaxPrice();
    priceRange = RangeValues(0, maxPropertyPrice);

    languages = AppLocalizations.supportedLocales.map((e) => e.languageCode).toList();

    safeEmit(DataLoadedState(
      listings: listings,
      languages: languages,
      priceRange: priceRange,
      isPageFiltered: false,
      user: user,
    ));
  }

  void resetFilter() async {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 100));
    final user = await _userService.getLoggedUser();
    safeEmit(DataLoadedState(
      listings: listings,
      languages: languages,
      priceRange: priceRange,
      isPageFiltered: false,
      user: user,
    ));
  }

  void filter({
    required FilterType filterType,
    double? minimPrice,
    double? maxPrice,
  }) async {
    safeEmit(PendingState());
    List<Listing> filteredListings = [];

    switch (filterType) {
      case FilterType.house:
        filteredListings = listings.where((element) => element.property.propertyType == PropertyType.house).toList();
      case FilterType.apartment:
        filteredListings =
            listings.where((element) => element.property.propertyType == PropertyType.apartment).toList();
      case FilterType.rent:
        filteredListings = listings.where((element) => element.property.listingType == ListingType.rent).toList();
        break;
      case FilterType.sale:
        filteredListings = listings.where((element) => element.property.listingType == ListingType.sale).toList();
      case FilterType.price:
        filteredListings = listings.where((element) {
          return element.property.price > minimPrice! && element.property.price < maxPrice!;
        }).toList();
      case FilterType.location:
        filteredListings = listings;
      case FilterType.reset:
        filteredListings = listings;
    }

    Future.delayed(const Duration(milliseconds: 100));
    final user = await _userService.getLoggedUser();
    safeEmit(DataLoadedState(
      listings: filteredListings,
      languages: languages,
      priceRange: priceRange,
      isPageFiltered: true,
      user: user,
    ));
  }

  double getPropertyMaxPrice() {
    if (properties.isEmpty) {
      return 0;
    }
    double maxPrice = properties[0].price;
    for (var property in properties) {
      if (property.price > maxPrice) {
        maxPrice = property.price;
      }
    }

    return maxPrice;
  }
}
