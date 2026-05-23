part of 'package:homelinker/cubit/home/home_cubit.dart';

class DataLoadedState extends BaseState {
  const DataLoadedState({
    required this.listings,
    required this.languages,
    required this.priceRange,
    required this.user,
    required this.hasMore,
  });

  final List<ListingData> listings;
  final List<String> languages;

  /// Bounds of the underlying dataset's prices (always [0, maxPrice]).
  /// User-selected filter range lives in `PropertyFilterCubit`.
  final RangeValues priceRange;
  final User user;
  final bool hasMore;

  @override
  List<Object?> get props => [listings, languages, priceRange, user, hasMore];
}

class ListingAddedToFavoritesState extends BaseState {
  const ListingAddedToFavoritesState({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class ListingRemovedToFavoritesState extends BaseState {
  const ListingRemovedToFavoritesState({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class ListingAlreadyInFavoritesState extends BaseState {
  const ListingAlreadyInFavoritesState({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class ListingAlreadyRemovedFromFavoritesState extends BaseState {
  const ListingAlreadyRemovedFromFavoritesState({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}
