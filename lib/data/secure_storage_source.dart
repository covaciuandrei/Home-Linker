import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecureStorageSource {
  SecureStorageSource();

  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<void> set(String key, String value) =>
      _flutterSecureStorage.write(key: key, value: value);

  Future<String?> get(String key) => _flutterSecureStorage.read(key: key);

  Future<void> delete(String key) => _flutterSecureStorage.delete(key: key);
}
