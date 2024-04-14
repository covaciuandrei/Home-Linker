// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDto _$PropertyDtoFromJson(Map<String, dynamic> json) => PropertyDto(
      json['area_size'] as int? ?? 0,
      json['bathrooms'] as int? ?? 0,
      json['bedrooms'] as int? ?? 0,
      json['construction_year'] as int? ?? 0,
      json['description'] as String? ?? '',
      json['image_id'] as String? ?? '',
      json['listing_type'] as String? ?? '',
      json['location'] as String? ?? '',
      json['owner_email'] as String? ?? '',
      json['owner_name'] as String? ?? '',
      json['parking_spaces'] as int? ?? 0,
      (json['price'] as num?)?.toDouble() ?? 0.0,
      json['property_type'] as String? ?? '',
    );

Map<String, dynamic> _$PropertyDtoToJson(PropertyDto instance) =>
    <String, dynamic>{
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
    };
