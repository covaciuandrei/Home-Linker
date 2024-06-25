import 'dart:io';

import 'package:homelinker/data/database/database.dart';
import 'package:homelinker/data/database/expiration_time.dart';
import 'package:homelinker/data/repository/base_repository.dart';
import 'package:homelinker/models/image.dart' as model;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class ImageRepository extends BaseRepository {
  ImageRepository(super.databaseProvider);

  @override
  int get cachePeriod => ExpirationTimesConstants.mediumTermTable;

  @override
  String get tableName => database.images.tableName!;

  Future<void> insert({
    required model.Image imageData,
    required File? imageFile,
    required String imageId,
  }) async {
    final bytes = await imageFile!.readAsBytes();

    final companion = ImagesCompanion.insert(
      identifier: imageId,
      data: bytes,
      path: imageData.path,
      uploadDate: imageData.uploadDate,
      name: imageData.name,
    );
    await database.into(database.images).insert(companion);

    return setLastUpdateNow(additionalParam: 'image:$imageId');
  }

  Future<void> clear({required String imageId}) async {
    await (database.delete(database.users)).go();
  }

  Future<File> getImage({required String imageId}) async {
    final Image image = (await (database.select(database.images)..where((tbl) => tbl.identifier.equals(imageId))).get())[0];

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${image.name}');

    return file;
  }
}
