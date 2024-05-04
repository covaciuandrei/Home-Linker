part of 'package:homelinker/cubit/home/home_cubit.dart';

class DataLoadedState extends BaseState {
  DataLoadedState({
    required this.listings,
    required this.languages,
  });
  final List<Listing> listings;
  final List<String> languages;
}
