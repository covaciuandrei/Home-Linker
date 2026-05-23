part of 'package:homelinker/cubit/favorites/favorites_cubit.dart';

class DataLoadedState extends BaseState {
  const DataLoadedState({
    required this.listings,
    required this.languages,
    required this.priceRange,
    required this.isPageFiltered,
    required this.user,
  });

  final List<ListingData> listings;
  final List<String> languages;
  final RangeValues priceRange;
  final bool isPageFiltered;
  final User user;
}

class ListingAddedToFavoritesState extends BaseState {
  const ListingAddedToFavoritesState();
}

class ListingRemovedToFavoritesState extends BaseState {
  const ListingRemovedToFavoritesState();
}

class ListingAlreadyInFavoritesState extends BaseState {
  const ListingAlreadyInFavoritesState();
}

class ListingAlreadyRemovedFromFavoritesState extends BaseState {
  const ListingAlreadyRemovedFromFavoritesState();
}
