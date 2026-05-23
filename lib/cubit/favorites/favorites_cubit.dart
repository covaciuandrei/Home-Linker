import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/data/database/database_provider.dart';
import 'package:homelinker/models/enums/filter_type.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/listing_data.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/favorites/favorites_states.dart';

@injectable
class FavoritesCubit extends BaseCubit {
  FavoritesCubit(
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

  List<String> languages = [];
  List<ListingData> listingsData = [];
  RangeValues priceRange = const RangeValues(0, 1000000);

  Future<void> deleteData() async {
    await _databaseProvider.get.clear();
  }

  Future<void> refresh() async {
    await _internalLoad(forceRefresh: true);
  }

  Future<void> load() async {
    await _internalLoad();
  }

  Future<void> _internalLoad({bool forceRefresh = false}) async {
    safeEmit(PendingState());
    await Future.delayed(const Duration(milliseconds: 200));

    final user = await _userService.getLoggedUser(forceRefresh: forceRefresh);
    final savedListings = user.favoriteListingsIds.toSet();

    final allProperties = await _propertyService.getAll(forceRefresh: forceRefresh);
    properties = allProperties.where((property) => savedListings.contains(property.id)).toList();

    listingsData = await Future.wait(properties.map((property) async {
      final image = await _imageService.getImage(imageId: property.imageId).catchError((_) => null);
      return ListingData(
        listing: Listing(image: image, property: property),
        isSaved: true,
      );
    }));

    final maxPropertyPrice = getPropertyMaxPrice();
    priceRange = RangeValues(0, maxPropertyPrice);

    languages = AppLocalizations.supportedLocales.map((e) => e.languageCode).toList();

    safeEmit(DataLoadedState(
      listings: listingsData,
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
      listings: listingsData,
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
    List<ListingData> filteredListings = [];

    switch (filterType) {
      case FilterType.house:
        filteredListings =
            listingsData.where((element) => element.listing.property.propertyType == PropertyType.house).toList();
      case FilterType.apartment:
        filteredListings =
            listingsData.where((element) => element.listing.property.propertyType == PropertyType.apartment).toList();
      case FilterType.rent:
        filteredListings =
            listingsData.where((element) => element.listing.property.listingType == ListingType.rent).toList();
        break;
      case FilterType.sale:
        filteredListings =
            listingsData.where((element) => element.listing.property.listingType == ListingType.sale).toList();
      case FilterType.price:
        filteredListings = listingsData.where((element) {
          return element.listing.property.price >= minimPrice! && element.listing.property.price <= maxPrice!;
        }).toList();
      case FilterType.location:
        filteredListings = listingsData;
      case FilterType.reset:
        filteredListings = listingsData;
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

  Future<void> addListingToFavorites({required String id}) async {
    safeEmit(PendingState());

    final user = await _userService.getLoggedUser();

    if (user.favoriteListingsIds.contains(id)) {
      safeEmit(const ListingAlreadyInFavoritesState());
      return;
    }

    try {
      await _userService.addListingToFavorites(id: id);

      safeEmit(const ListingAddedToFavoritesState());
      await _internalLoad(forceRefresh: true);
    } catch (_) {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<void> removeListingToFavorites({required String id}) async {
    safeEmit(PendingState());

    final user = await _userService.getLoggedUser();

    if (!user.favoriteListingsIds.contains(id)) {
      safeEmit(const ListingAlreadyRemovedFromFavoritesState());
      return;
    }

    try {
      await _userService.removeListingToFavorites(id: id);

      listingsData = listingsData.where((element) => element.listing.property.id != id).toList();
      properties = properties.where((property) => property.id != id).toList();
      priceRange = RangeValues(0, getPropertyMaxPrice());

      safeEmit(const ListingRemovedToFavoritesState());

      final updatedUser = await _userService.getLoggedUser();
      safeEmit(DataLoadedState(
        listings: listingsData,
        languages: languages,
        priceRange: priceRange,
        isPageFiltered: false,
        user: updatedUser,
      ));
    } catch (_) {
      safeEmit(SomethingWentWrongState());
    }
  }
}
