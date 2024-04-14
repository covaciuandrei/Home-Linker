import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/property_mapper.dart';
import 'package:homelinker/data/remote/property/property_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

@injectable
class PropertySource {
  PropertySource(
    this._propertyMapper,
  );
  final PropertyMapper _propertyMapper;

  CollectionReference<PropertyDto> get _collectionRef =>
      FirebaseFirestore.instance
          .collection(RemoteSourceNames.properties)
          .withConverter<PropertyDto>(
            fromFirestore: (snapshots, _) =>
                PropertyDto.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<List<Property>> getAll() async {
    final querySnapshot = await _collectionRef.get();
    final propertyDtos = querySnapshot.docs.map((doc) => doc.data()).toList();

    return _propertyMapper.mapPropertyDtos(propertyDtos);
  }

  Future<void> insert(Property newProperty) async {
    try {
      _collectionRef.add(_propertyMapper.mapPropertyToDto(newProperty));
    } catch (ex) {
      print(ex);
    }
  }

  
}
