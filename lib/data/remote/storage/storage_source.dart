import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class StorageSource {
  Reference get _storageRef => FirebaseStorage.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile({
    required String filePath,
    required String filePathRemote,
  }) async {
    final File file = File(filePath);

    await storage.ref(filePathRemote).putFile(file);
  }

  Future<bool> doesFileExist(String filePathRemote) async {
    try {
      final fileRef = _storageRef.child(filePathRemote);

      final FullMetadata metadata = await fileRef.getMetadata();

      return metadata.size != null;
    } on Exception {
      return false;
    }
  }

  Future<File?> downloadImage({
    required String imagePath,
    required String name,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref(imagePath);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$name');
      await ref.getMetadata();
      await ref.writeToFile(file);

      return file;
    } on Exception catch (e) {
      print(e);
    }
  }
}
