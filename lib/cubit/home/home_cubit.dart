import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/data/database/database_provider.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/listing_data.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/home/home_states.dart';

/// Owns the home feed's data: listings, pagination cursor, favourites flags,
/// and metadata (locale list, max-price bound). All filter selection state is
/// owned by `PropertyFilterCubit`; this cubit is intentionally filter-agnostic.
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

  static const int _pageSize = 20;

  List<ListingData> _listingsData = [];
  List<String> _languages = [];
  double _maxPrice = 0;
  User? _user;

  String? _lastId;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> deleteData() async {
    await _databaseProvider.get.clear();
  }

  Future<void> refresh() async {
    _lastId = null;
    _hasMore = true;
    _listingsData = [];
    await _loadFirstPage(forceRefresh: true);
  }

  Future<void> load() async {
    await _loadFirstPage();
  }

  Future<void> _loadFirstPage({bool forceRefresh = false}) async {
    safeEmit(PendingState());
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final user = await _userService.getLoggedUser(forceRefresh: forceRefresh);
    final savedListings = user.favoriteListingsIds.toSet();
    _user = user;

    final firstPage = await _propertyService.getPage(pageSize: _pageSize);
    _hasMore = firstPage.length == _pageSize;
    _lastId = firstPage.isNotEmpty ? firstPage.last.id : null;

    _listingsData = await _hydrate(firstPage, savedListings);
    _maxPrice = _computeMaxPrice(_listingsData);
    _languages = AppLocalizations.supportedLocales.map((e) => e.languageCode).toList();

    safeEmit(_buildLoadedState());
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore || _user == null) return;
    _isLoadingMore = true;
    try {
      final user = _user!;
      final savedListings = user.favoriteListingsIds.toSet();
      final next = await _propertyService.getPage(pageSize: _pageSize, startAfterId: _lastId);
      _hasMore = next.length == _pageSize;
      if (next.isNotEmpty) {
        _lastId = next.last.id;
        final hydrated = await _hydrate(next, savedListings);
        _listingsData = [..._listingsData, ...hydrated];
        _maxPrice = _computeMaxPrice(_listingsData);
        safeEmit(_buildLoadedState());
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<List<ListingData>> _hydrate(List<Property> properties, Set<String> saved) async {
    final hydrated = <ListingData>[];
    for (final property in properties) {
      final image = await _imageService.getImage(imageId: property.imageId);
      if (image == null) continue;
      hydrated.add(ListingData(
        listing: Listing(image: image, property: property),
        isSaved: saved.contains(property.id),
      ));
    }
    return hydrated;
  }

  double _computeMaxPrice(List<ListingData> data) {
    if (data.isEmpty) return 0;
    var max = data.first.listing.property.price;
    for (final element in data) {
      if (element.listing.property.price > max) max = element.listing.property.price;
    }
    return max;
  }

  DataLoadedState _buildLoadedState() {
    return DataLoadedState(
      listings: List.unmodifiable(_listingsData),
      languages: _languages,
      priceRange: RangeValues(0, _maxPrice),
      user: _user!,
      hasMore: _hasMore,
    );
  }

  Future<void> addListingToFavorites({required String id, required int index}) async {
    final user = await _userService.getLoggedUser();
    _user = user;

    if (user.favoriteListingsIds.contains(id)) {
      safeEmit(ListingAlreadyInFavoritesState(index: index));
      safeEmit(_buildLoadedState());
      return;
    }

    try {
      await _userService.addListingToFavorites(id: id);
      _updateSavedFlag(index, true);
      safeEmit(ListingAddedToFavoritesState(index: index));
      safeEmit(_buildLoadedState());
    } catch (_) {
      safeEmit(SomethingWentWrongState());
      safeEmit(_buildLoadedState());
    }
  }

  Future<void> removeListingToFavorites({required String id, required int index}) async {
    final user = await _userService.getLoggedUser();
    _user = user;

    if (!user.favoriteListingsIds.contains(id)) {
      safeEmit(ListingAlreadyRemovedFromFavoritesState(index: index));
      safeEmit(_buildLoadedState());
      return;
    }

    try {
      await _userService.removeListingToFavorites(id: id);
      _updateSavedFlag(index, false);
      safeEmit(ListingRemovedToFavoritesState(index: index));
      safeEmit(_buildLoadedState());
    } catch (_) {
      safeEmit(SomethingWentWrongState());
      safeEmit(_buildLoadedState());
    }
  }

  void _updateSavedFlag(int index, bool isSaved) {
    if (index < 0 || index >= _listingsData.length) return;
    final current = _listingsData[index];
    _listingsData = [..._listingsData];
    _listingsData[index] = ListingData(listing: current.listing, isSaved: isSaved);
  }
}
