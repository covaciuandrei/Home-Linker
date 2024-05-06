import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/app_version_mapper.dart';
import 'package:homelinker/data/remote/app_version/app_version_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppVersionSource {
  AppVersionSource(this._appVersionMapper);

  final AppVersionMapper _appVersionMapper;

  CollectionReference<AppVersionDto> get _collectionRef =>
      FirebaseFirestore.instance.collection(RemoteSourceNames.versions).withConverter<AppVersionDto>(
            fromFirestore: (snapshots, _) => AppVersionDto.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<AppVersion> get() async {
    final querySnapshot = await _collectionRef.orderBy('release_date', descending: true).limit(1).get();
    final appVersionDto = querySnapshot.docs.map((doc) => doc.data()).single;
    return _appVersionMapper.mapAppVersionDto(appVersionDto);
  }
}
