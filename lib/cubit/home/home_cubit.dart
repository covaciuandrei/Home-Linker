import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/filters.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/home/home_states.dart';

@injectable
class HomeCubit extends BaseCubit {
  HomeCubit(this._propertyService) : super(InitialState());
  final PropertyService _propertyService;

  List<Property> properties = [];
  Future<void> load() async {
    safeEmit(PendingState());
    await Future.delayed(const Duration(milliseconds: 200));
    properties = await _propertyService.getAll();
    safeEmit(DataLoadedState(properties: properties));
  }

  void resetFilter() {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 100));
    safeEmit(DataLoadedState(properties: properties));
  }

  void filter({required FilterType filterType}) {
    safeEmit(PendingState());
    List<Property> filteredProperties = [];

    switch (filterType) {
      case FilterType.house:
        filteredProperties = properties
            .where((element) => element.propertyType == PropertyType.house)
            .toList();
      case FilterType.apartment:
        filteredProperties = properties
            .where((element) => element.propertyType == PropertyType.apartment)
            .toList();
      case FilterType.rent:
        filteredProperties = properties
            .where((element) => element.listingType == ListingType.rent)
            .toList();
        break;
      case FilterType.sale:
        filteredProperties = properties
            .where((element) => element.listingType == ListingType.sale)
            .toList();
      case FilterType.price:
        filteredProperties = properties;
      case FilterType.location:
        filteredProperties = properties;
    }

    Future.delayed(const Duration(milliseconds: 100));

    safeEmit(DataLoadedState(properties: filteredProperties));
  }
}
