import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/data/database/database_provider.dart';
import 'package:homelinker/models/enums/filter_type.dart';
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
    final savedListings = user.favoriteListingsIds;

    properties = await _propertyService.getAll(forceRefresh: forceRefresh);

    listingsData = [];

    for (final property in properties) {
      final image = await _imageService.getImage(imageId: property.imageId);

      final listing = Listing(image: image!, property: property);

      final isSaved = savedListings.contains(property.id);

      final listingData = ListingData(listing: listing, isSaved: isSaved);

      listingsData.add(listingData);
    }

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

  Future<void> applyFilters({
    PropertyType? propertyType,
    ListingType? listingType,
    double? minPrice,
    double? maxPrice,
  }) async {
    safeEmit(PendingState());

    final hasPrice = minPrice != null && maxPrice != null;
    final isFiltered = propertyType != null || listingType != null || hasPrice;

    final filtered = listingsData.where((element) {
      final property = element.listing.property;
      if (propertyType != null && property.propertyType != propertyType) {
        return false;
      }
      if (listingType != null && property.listingType != listingType) {
        return false;
      }
      if (hasPrice && (property.price < minPrice || property.price > maxPrice)) {
        return false;
      }
      return true;
    }).toList();

    final user = await _userService.getLoggedUser();
    safeEmit(DataLoadedState(
      listings: filtered,
      languages: languages,
      priceRange: priceRange,
      isPageFiltered: isFiltered,
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
          return element.listing.property.price > minimPrice! && element.listing.property.price < maxPrice!;
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

  Future<void> addListingToFavorites({required String id, required int index}) async {
    safeEmit(PendingState());

    final user = await _userService.getLoggedUser();

    if (user.favoriteListingsIds.contains(id)) {
      safeEmit(ListingAlreadyInFavoritesState(index: index));
      return;
    }

    try {
      await _userService.addListingToFavorites(id: id);

      safeEmit(ListingAddedToFavoritesState(index: index));
    } catch (_) {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<void> removeListingToFavorites({required String id, required int index}) async {
    safeEmit(PendingState());

    final user = await _userService.getLoggedUser();

    if (!user.favoriteListingsIds.contains(id)) {
      safeEmit(ListingAlreadyRemovedFromFavoritesState(index: index));
      return;
    }

    try {
      await _userService.removeListingToFavorites(id: id);

      safeEmit(ListingRemovedToFavoritesState(index: index));
    } catch (_) {
      safeEmit(SomethingWentWrongState());
    }
  }
}

class ListingData extends Equatable {
  const ListingData({required this.listing, required this.isSaved});

  final Listing listing;
  final bool isSaved;

  @override
  List<Object?> get props => [
        listing,
        isSaved,
      ];
}
