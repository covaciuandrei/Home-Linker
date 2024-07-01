import 'package:homelinker/data/database/database.dart' as database;
import 'package:homelinker/data/remote/property/property_dto.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertyMapper {
  Property mapDtoToProperty(PropertyDto dto) => Property(
        id: dto.id ?? '',
        areaSize: dto.areaSize,
        bathrooms: dto.bathrooms,
        bedrooms: dto.bedrooms,
        constructionYear: dto.constructionYear,
        description: dto.description,
        imageId: dto.imageId,
        listingType: ListingType.values.byName(dto.listingType),
        location: dto.location,
        ownerEmail: dto.ownerEmail,
        ownerName: dto.ownerName,
        parkingSpaces: dto.parkingSpaces,
        price: dto.price,
        propertyType: PropertyType.values.byName(dto.propertyType),
      );

  List<Property> mapPropertyDtos(List<PropertyDto> propertyDtos) => propertyDtos.map(mapDtoToProperty).toList();

  PropertyDto mapPropertyToDto(Property property) => PropertyDto(
        property.areaSize,
        property.bathrooms,
        property.bedrooms,
        property.constructionYear,
        property.description,
        property.imageId,
        property.listingType.name,
        property.location,
        property.ownerEmail,
        property.ownerName,
        property.parkingSpaces,
        property.price,
        property.propertyType.name,
      );
  List<PropertyDto> mapPropertiesToDtos(List<Property> properties) => properties.map(mapPropertyToDto).toList();

  Property mapPropertyFromDatabase(database.Property dto) => Property(
        areaSize: dto.areaSize,
        bathrooms: dto.bathrooms,
        bedrooms: dto.bedrooms,
        constructionYear: dto.constructionYear,
        description: dto.description,
        imageId: dto.imageId,
        listingType: ListingType.values.byName(dto.listingType),
        location: dto.location,
        ownerEmail: dto.ownerEmail,
        ownerName: dto.ownerName,
        parkingSpaces: dto.parkingSpaces,
        price: dto.price,
        propertyType: PropertyType.values.byName(dto.propertyType),
      );
}
