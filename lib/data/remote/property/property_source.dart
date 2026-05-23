import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/property_mapper.dart';
import 'package:homelinker/data/remote/property/property_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/place_location.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertySource {
  PropertySource(
    this._propertyMapper,
  );
  final PropertyMapper _propertyMapper;

  CollectionReference<PropertyDto> get _collectionRef =>
      FirebaseFirestore.instance.collection(RemoteSourceNames.properties).withConverter<PropertyDto>(
            fromFirestore: (snapshots, _) => PropertyDto.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<List<Property>> getAll() async {
    final querySnapshot = await _collectionRef.get();

    final propertyDtos = querySnapshot.docs.map(_mapDocumentToDto).toList();

    return _propertyMapper.mapPropertyDtos(propertyDtos);
  }

  /// Cursor-based pagination over every property document.
  ///
  /// Firestore orderBy excludes documents that are missing the ordered field,
  /// so we sort in memory here to guarantee legacy/incomplete listings still
  /// appear. Listings with `created_at` are shown newest first; missing dates
  /// are kept at the end and ordered by id.
  Future<List<Property>> getPage({
    int pageSize = 20,
    String? startAfterCreatedAt,
    String? startAfterId,
  }) async {
    final querySnapshot = await _collectionRef.get();
    final properties = _propertyMapper.mapPropertyDtos(querySnapshot.docs.map(_mapDocumentToDto).toList())
      ..sort(_comparePropertiesForFeed);

    final startIndex = _startIndexAfterCursor(
      properties,
      startAfterCreatedAt: startAfterCreatedAt,
      startAfterId: startAfterId,
    );
    return properties.skip(startIndex).take(pageSize).toList();
  }

  PropertyDto _mapDocumentToDto(QueryDocumentSnapshot<PropertyDto> doc) {
    final data = doc.data();
    final address = _addressFromLocation(data.location);

    return PropertyDto(
      id: doc.id,
      data.areaSize,
      data.bathrooms,
      data.bedrooms,
      data.constructionYear,
      data.description,
      data.imageId,
      data.listingType,
      address,
      data.ownerEmail,
      data.ownerName,
      data.parkingSpaces,
      data.price,
      data.propertyType,
      createdAt: data.createdAt,
    );
  }

  String _addressFromLocation(String locationJsonString) {
    if (locationJsonString.isEmpty) return '';
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(locationJsonString);
      return PlaceLocation.fromJson(jsonMap).address;
    } catch (_) {
      return '';
    }
  }

  int _comparePropertiesForFeed(Property a, Property b) {
    final aCreatedAt = a.createdAt;
    final bCreatedAt = b.createdAt;
    if (aCreatedAt == null && bCreatedAt == null) return a.id.compareTo(b.id);
    if (aCreatedAt == null) return 1;
    if (bCreatedAt == null) return -1;

    final byCreatedAt = bCreatedAt.compareTo(aCreatedAt);
    if (byCreatedAt != 0) return byCreatedAt;
    return a.id.compareTo(b.id);
  }

  int _startIndexAfterCursor(
    List<Property> properties, {
    required String? startAfterCreatedAt,
    required String? startAfterId,
  }) {
    if (startAfterId == null || startAfterId.isEmpty) return 0;

    final exactCursorIndex = properties.indexWhere((property) => property.id == startAfterId);
    if (exactCursorIndex >= 0) return exactCursorIndex + 1;

    final cursorDate = startAfterCreatedAt != null ? DateTime.tryParse(startAfterCreatedAt) : null;
    final inferredIndex = properties.indexWhere((property) => _isAfterCursor(property, cursorDate, startAfterId));
    return inferredIndex == -1 ? properties.length : inferredIndex;
  }

  bool _isAfterCursor(Property property, DateTime? cursorDate, String cursorId) {
    final propertyCreatedAt = property.createdAt;
    if (cursorDate == null) {
      if (propertyCreatedAt != null) return false;
      return property.id.compareTo(cursorId) > 0;
    }
    if (propertyCreatedAt == null) return true;

    final byCreatedAt = cursorDate.compareTo(propertyCreatedAt);
    if (byCreatedAt != 0) return byCreatedAt > 0;
    return property.id.compareTo(cursorId) > 0;
  }

  Future<void> insert(Property newProperty) async {
    try {
      await _collectionRef.add(_propertyMapper.mapPropertyToDto(newProperty));
    } on Exception {
      throw Exception();
    }
  }

  Future<void> delete({required String propertyId}) async {
    final documentRef = _collectionRef.doc(propertyId);
    await documentRef.delete();
  }
}
