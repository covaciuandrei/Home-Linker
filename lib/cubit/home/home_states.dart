part of 'package:homelinker/cubit/home/home_cubit.dart';

class DataLoadedState extends BaseState {
  DataLoadedState({required this.listings});
  final List<Listing> listings;
}
