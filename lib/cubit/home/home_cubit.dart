import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/home/home_states.dart';

@injectable
class HomeCubit extends BaseCubit {
  HomeCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());
    Future.delayed(const Duration(seconds: 1),
        () => safeEmit(DataLoadedState(properties: properties)));
  }
}

List<Property> properties = [
  Property(
    areaSize: 40,
    imageLink:
        'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    listingType: ListingType.sale,
    location: 'Bucharest, Romania',
    ownerName: 'Andrei Covaciu',
    price: 50000,
    type: PropertyType.apartment,
  ),
  Property(
    areaSize: 120,
    imageLink:
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    listingType: ListingType.rent,
    location: 'Valcea, Romania',
    ownerName: 'Sebastian Dancau',
    price: 950,
    type: PropertyType.apartment,
  ),
  Property(
    areaSize: 250,
    imageLink:
        'https://source.unsplash.com/two-orange-sofa-chairs-inside-room-0u0kKxfpvQ0',
    listingType: ListingType.sale,
    location: 'Valcea, Romania',
    ownerName: 'Andrei Covaciu',
    price: 375000,
    type: PropertyType.house,
  ),
  Property(
    areaSize: 215,
    imageLink:
        'https://source.unsplash.com/gray-fabric-loveseat-near-brown-wooden-table-3wylDrjxH-E',
    listingType: ListingType.rent,
    location: 'Milano, Italy',
    ownerName: 'Andrei Covaciu',
    price: 4000,
    type: PropertyType.house,
  ),
  Property(
    areaSize: 215,
    imageLink:
        'https://source.unsplash.com/patio-set-in-terrace-overlooking-city-xQWLtlQb7L0',
    listingType: ListingType.sale,
    location: 'Milano, Italy',
    ownerName: 'Matteo Darmian',
    price: 625000,
    type: PropertyType.house,
  ),
];
