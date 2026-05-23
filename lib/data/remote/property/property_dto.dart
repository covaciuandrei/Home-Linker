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
      json['area_size'] as int,
      json['bathrooms'] as int,
      json['bedrooms'] as int,
      json['construction_year'] as int,
      json['description'] as String,
      json['image_id'] as String,
      json['listing_type'] as String,
      json['location'] as String,
      json['owner_email'] as String,
      json['owner_name'] as String,
      json['parking_spaces'] as int,
      (json['price'] as num).toDouble(),
      json['property_type'] as String,
      createdAt: json['created_at'] as String?,
    );

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
