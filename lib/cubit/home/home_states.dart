part of 'package:homelinker/cubit/home/home_cubit.dart';

class DataLoadedState extends BaseState {
  DataLoadedState({
    required this.listings,
    required this.languages,
    required this.priceRange,
    required this.isPageFiltered,
    required this.user,
  });

  final List<Listing> listings;
  final List<String> languages;
  final RangeValues priceRange;
  final bool isPageFiltered;
  final User user;
}
