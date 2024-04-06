import 'package:homelinker/data/remote/user/user_source.dart';
import 'package:homelinker/data/secure_storage/secure_storage_keys.dart';
import 'package:homelinker/data/secure_storage/secure_storage_source.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  UserService(
    this._userSource,
    this._secureStorageSource,
  );

  final UserSource _userSource;
  final SecureStorageSource _secureStorageSource;

  Future<User> getLoggedUser() async {
    final email = await _secureStorageSource.get(SecureStorageKeys.userEmail);
    final user = await _userSource.get(email!);
    return user;
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String phoneNumber,
    required AccountType accountType,
  }) async {
    await _userSource.createUser(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      accountType: accountType,
    );
  }
}
