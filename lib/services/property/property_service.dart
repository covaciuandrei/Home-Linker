import 'package:homelinker/data/remote/property/property_source.dart';
import 'package:homelinker/data/secure_storage/secure_storage_source.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertyService {
  PropertyService(this._propertySource, this._secureStorageSource);

  final PropertySource _propertySource;
  final SecureStorageSource _secureStorageSource;

  Future<List<Property>> getAll() async {
    final properties = await _propertySource.getAll();
    return properties;
  }

  Future<void> addNewProperty({
    // required int areaSize,
    // required int bathrooms,
    // required int bedrooms,
    // required int constructionYear,
    // required String imageLink,
    // required String listingType,
    // required String location,
    // required String ownerEmail,
    // required String ownerName,
    // required int parkingSpaces,
    // required double price,
    // required String propertyType,
    required Property property,
  }) async {
    // final newProperty = Property(
    //   areaSize: areaSize,
    //   bathrooms: bathrooms,
    //   bedrooms: bedrooms,
    //   constructionYear: constructionYear,
    //   imageLink: imageLink,
    //   listingType: ListingType.values.byName(listingType),
    //   location: location,
    //   ownerEmail: ownerEmail,
    //   ownerName: ownerName,
    //   parkingSpaces: parkingSpaces,
    //   price: price,
    //   propertyType: PropertyType.values.byName(propertyType),
    // );
    final newProperty = property;
    await _propertySource.insert(newProperty);
  }
}
