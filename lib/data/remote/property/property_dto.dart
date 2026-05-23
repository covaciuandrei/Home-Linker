class PropertyDto {
  PropertyDto(
      this.areaSize,
      this.bathrooms,
      this.bedrooms,
      this.constructionYear,
      this.description,
      this.imageId,
      this.listingType,
      this.location,
      this.ownerEmail,
      this.ownerName,
      this.parkingSpaces,
      this.price,
      this.propertyType,
      {this.id = '',
      this.createdAt});

  factory PropertyDto.fromJson(Map<String, dynamic> json) => _$PropertyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDtoToJson(this);

  final int areaSize;
  final int bathrooms;
  final int bedrooms;
  final int constructionYear;
  final String description;
  final String imageId;
  final String listingType;
  final String location;
  final String ownerEmail;
  final String ownerName;
  final int parkingSpaces;
  final double price;
  final String propertyType;
  final String? id;
  final String? createdAt;
}

PropertyDto _$PropertyDtoFromJson(Map<String, dynamic> json) => PropertyDto(
      _jsonInt(json['area_size']),
      _jsonInt(json['bathrooms']),
      _jsonInt(json['bedrooms']),
      _jsonInt(json['construction_year']),
      _jsonString(json['description']),
      _jsonString(json['image_id']),
      _jsonString(json['listing_type'], fallback: 'sale'),
      _jsonString(json['location']),
      _jsonString(json['owner_email']),
      _jsonString(json['owner_name']),
      _jsonInt(json['parking_spaces']),
      _jsonDouble(json['price']),
      _jsonString(json['property_type'], fallback: 'apartment'),
      createdAt: _jsonNullableString(json['created_at']),
    );

String _jsonString(Object? value, {String fallback = ''}) {
  if (value is String) return value;
  if (value == null) return fallback;
  return value.toString();
}

String? _jsonNullableString(Object? value) {
  if (value is String && value.isNotEmpty) return value;
  return null;
}

int _jsonInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double _jsonDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

Map<String, dynamic> _$PropertyDtoToJson(PropertyDto instance) => <String, dynamic>{
      'area_size': instance.areaSize,
      'bathrooms': instance.bathrooms,
      'bedrooms': instance.bedrooms,
      'construction_year': instance.constructionYear,
      'description': instance.description,
      'image_id': instance.imageId,
      'listing_type': instance.listingType,
      'location': instance.location,
      'owner_email': instance.ownerEmail,
      'owner_name': instance.ownerName,
      'parking_spaces': instance.parkingSpaces,
      'price': instance.price,
      'property_type': instance.propertyType,
      if (instance.createdAt != null) 'created_at': instance.createdAt,
    };
