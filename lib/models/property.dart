class Property {
  Property({
    required this.ownerName,
    required this.propertyType,
    required this.areaSize,
    required this.location,
    required this.price,
    required this.imageLink,
    required this.listingType,
  });
  final String ownerName;
  final PropertyType propertyType;
  final int areaSize;
  final String location;
  final double price;
  final String imageLink;
  final ListingType listingType;
}

enum PropertyType { apartment, house }

enum ListingType { sale, rent }
