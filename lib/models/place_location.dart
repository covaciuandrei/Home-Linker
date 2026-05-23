import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation extends Equatable {
  const PlaceLocation({
    required this.latLng,
    required this.address,
  });

  final LatLng latLng;
  final String address;

  @override
  List<Object?> get props => [latLng, address];

  Map<String, dynamic> toJson() {
    return {
      'latLng': {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      },
      'address': address,
    };
  }

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latLng: LatLng(
        json['latLng']['latitude'],
        json['latLng']['longitude'],
      ),
      address: json['address'],
    );
  }
}
