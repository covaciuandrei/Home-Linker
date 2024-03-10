class Property {
  Property({
    required this.ownerName,
    required this.propertyType,
    required this.areaSize,
    required this.location,
    required this.price,
    required this.imageLink,
    required this.listingType,
    required this.isFavorite,
    required this.bathrooms,
    required this.bedrooms,
    required this.constructionYear,
    required this.parkingSpaces,
  });
  final String ownerName;
  final PropertyType propertyType;
  final int areaSize;
  final String location;
  final double price;
  final String imageLink;
  final ListingType listingType;
  final bool isFavorite;
  final int bathrooms;
  final int bedrooms;
  final int constructionYear;
  final int parkingSpaces;
}

enum PropertyType { apartment, house }

enum ListingType { sale, rent }
