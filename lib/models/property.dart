class Property {
  Property({
    required this.ownerId,
    required this.ownerName,
    required this.type,
    required this.areaSize,
    required this.location,
  });
  final int ownerId;
  final String ownerName;
  final PropertyType type;
  final int areaSize;
  final String location;
}

enum PropertyType { apartment, house }
