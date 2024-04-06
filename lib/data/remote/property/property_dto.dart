import 'package:json_annotation/json_annotation.dart';

part 'property_dto.g.dart';

@JsonSerializable()
class PropertyDto {
  PropertyDto(
    this.areaSize,
    this.bathrooms,
    this.bedrooms,
    this.constructionYear,
    this.imageLink,
    this.listingType,
    this.location,
    this.ownerEmail,
    this.ownerName,
    this.parkingSpaces,
    this.price,
    this.propertyType,
  );

  factory PropertyDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDtoToJson(this);

  @JsonKey(name: 'area_size', defaultValue: 0)
  final int areaSize;

  @JsonKey(name: 'bathrooms', defaultValue: 0)
  final int bathrooms;

  @JsonKey(name: 'bedrooms', defaultValue: 0)
  final int bedrooms;

  @JsonKey(name: 'construction_year', defaultValue: 0)
  final int constructionYear;

  @JsonKey(name: 'image_link', defaultValue: '')
  final String imageLink;

  @JsonKey(name: 'listing_type', defaultValue: '')
  final String listingType;

  @JsonKey(name: 'location', defaultValue: '')
  final String location;

  @JsonKey(name: 'owner_email', defaultValue: '')
  final String ownerEmail;

  @JsonKey(name: 'owner_name', defaultValue: '')
  final String ownerName;

  @JsonKey(name: 'parking_spaces', defaultValue: 0)
  final int parkingSpaces;

  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;

  @JsonKey(name: 'property_type', defaultValue: '')
  final String propertyType;
}
