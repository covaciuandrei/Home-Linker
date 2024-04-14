import 'package:homelinker/data/remote/property/property_source.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertyService {
  PropertyService(this._propertySource);

  final PropertySource _propertySource;

  Future<List<Property>> getAll() async {
    final properties = await _propertySource.getAll();
    return properties;
  }

  Future<void> addNewProperty({
    required Property property,
  }) async {
    final newProperty = property;
    await _propertySource.insert(newProperty);
  }

  Future<void> delete({required String propertyId}) async {
    await _propertySource.delete(propertyId: propertyId);
  }
}
