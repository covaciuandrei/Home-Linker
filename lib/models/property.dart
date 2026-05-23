import 'package:equatable/equatable.dart';

class Property extends Equatable {
  const Property({
    this.id = '',
    required this.areaSize,
    required this.bathrooms,
    required this.bedrooms,
    required this.constructionYear,
    required this.description,
    required this.imageId,
    required this.listingType,
    required this.location,
    required this.ownerEmail,
    required this.ownerName,
    required this.parkingSpaces,
    required this.price,
    required this.propertyType,
    this.createdAt,
  });

  final String id;
  final int areaSize;
  final int bathrooms;
  final int bedrooms;
  final int constructionYear;
  final String description;
  final String imageId;
  final ListingType listingType;
  final String location;
  final String ownerEmail;
  final String ownerName;
  final int parkingSpaces;
  final double price;
  final PropertyType propertyType;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        areaSize,
        bathrooms,
        bedrooms,
        constructionYear,
        description,
        imageId,
        listingType,
        location,
        ownerEmail,
        ownerName,
        parkingSpaces,
        price,
        propertyType,
        createdAt,
      ];
}

enum PropertyType { apartment, house }

enum ListingType { sale, rent }
