import 'package:homelinker/data/database/database.dart';
import 'package:homelinker/data/database/expiration_time.dart';
import 'package:homelinker/data/mappers/property_mapper.dart';
import 'package:homelinker/data/repository/base_repository.dart';
import 'package:homelinker/models/property.dart' as model;
import 'package:injectable/injectable.dart';

@injectable
class PropertyRepository extends BaseRepository {
  PropertyRepository(this._propertyMapper, super.databaseProvider);

  final PropertyMapper _propertyMapper;

  @override
  int get cachePeriod => ExpirationTimesConstants.mediumTermTable;

  @override
  String get tableName => database.properties.tableName!;

  Future<List<model.Property>> getAll() async {
    final properties = (await (database.select(database.properties)).get());

    return properties.map(_propertyMapper.mapPropertyFromDatabase).toList();
  }

  Future<void> insert({required List<model.Property> properties}) async {
    for (final property in properties) {
      final companion = PropertiesCompanion.insert(
        id: property.id,
        areaSize: property.areaSize,
        bathrooms: property.bathrooms,
        bedrooms: property.bedrooms,
        constructionYear: property.constructionYear,
        description: property.description,
        imageId: property.imageId,
        listingType: property.listingType.name,
        location: property.location,
        ownerEmail: property.ownerEmail,
        ownerName: property.ownerName,
        parkingSpaces: property.parkingSpaces,
        price: property.price,
        propertyType: property.propertyType.name,
      );
      await database.into(database.properties).insert(companion);
    }

    return setLastUpdateNow(additionalParam: 'documents');
  }

  Future<void> clear() async {
    await (database.delete(database.properties)).go();
  }
}
