part of 'package:homelinker/cubit/home/home_cubit.dart';

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
  const ListingAddedToFavoritesState({required this.index});

  final int index;
}

class ListingRemovedToFavoritesState extends BaseState {
  const ListingRemovedToFavoritesState({required this.index});

  final int index;
}

class ListingAlreadyInFavoritesState extends BaseState {
  const ListingAlreadyInFavoritesState({required this.index});

  final int index;
}

class ListingAlreadyRemovedFromFavoritesState extends BaseState {
  const ListingAlreadyRemovedFromFavoritesState({required this.index});

  final int index;
}
