import 'package:equatable/equatable.dart';
import 'package:homelinker/models/listing.dart';

class ListingData extends Equatable {
  const ListingData({required this.listing, required this.isSaved});

  final Listing listing;
  final bool isSaved;

  @override
  List<Object?> get props => [
        listing,
        isSaved,
      ];
}
