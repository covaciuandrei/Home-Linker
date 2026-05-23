import 'package:homelinker/data/remote/property/property_source.dart';
import 'package:homelinker/data/repository/property_repository.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertyService {
  PropertyService(
    this._propertySource,
    this._propertyRepository,
  );

  final PropertySource _propertySource;
  final PropertyRepository _propertyRepository;

  Future<List<Property>> getAll({bool? forceRefresh}) async {
    if (await _propertyRepository.isExpired(additionalParam: 'documents') || (forceRefresh != null && forceRefresh)) {
      final properties = await _propertySource.getAll();

      await _propertyRepository.clear();
      await _propertyRepository.insert(properties: properties);
      return properties;
    }
    return _propertyRepository.getAll();
  }

  /// Fetches a single page of properties from the remote source.
  ///
  /// Pagination bypasses the local cache by design — the cache is an
  /// offline-first snapshot for [getAll] and isn't sliced for ranged reads.
  Future<List<Property>> getPage({
    int pageSize = 20,
    String? startAfterCreatedAt,
    String? startAfterId,
  }) {
    return _propertySource.getPage(
      pageSize: pageSize,
      startAfterCreatedAt: startAfterCreatedAt,
      startAfterId: startAfterId,
    );
  }

  Future<void> addNewProperty({
    required Property property,
  }) async {
    final newProperty = property;
    await _propertySource.insert(newProperty);
    await _propertyRepository.invalidateCache(additionalParam: 'documents');
  }

  Future<void> delete({required String propertyId}) async {
    await _propertySource.delete(propertyId: propertyId);
    await _propertyRepository.invalidateCache(additionalParam: 'documents');
  }
}
