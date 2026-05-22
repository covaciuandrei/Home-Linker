import 'package:homelinker/data/remote/user/user_source.dart';
import 'package:homelinker/data/repository/user_repository.dart';
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
    this._userRepository,
  );

  final UserSource _userSource;
  final SecureStorageSource _secureStorageSource;
  final UserRepository _userRepository;

  Future<User> getLoggedUser({bool forceRefresh = false}) async {
    final email = await _secureStorageSource.get(SecureStorageKeys.userEmail);
    final userId = await _secureStorageSource.get(SecureStorageKeys.userId);

    if (await _userRepository.isExpired(additionalParam: userId!) || forceRefresh) {
      final user = await _userSource.get(email!);
      await _userRepository.clear(userId: userId);
      await _userRepository.insert(
        users: [user],
      );
      return user;
    }
    return _userRepository.get(userId);
  }

  Future<bool> set2FactorAuthCode({
    required String email,
    required String code,
  }) async {
    final wasCodeSet = await _userSource.set2FactorAuthCode(
      email: email,
      code: code,
    );
    return wasCodeSet;
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

  Future<void> deleteAccount() async {
    final userId = await _secureStorageSource.get(SecureStorageKeys.userId);

    return _userSource.deleteAccount(userId!);
  }

  Future<void> updateUser({
    String? imageId,
    List<String>? favoriteListingsIds,
  }) async {
    final user = await getLoggedUser();

    await _userSource.updateUser(
      userId: user.id,
      imageId: imageId,
      favoriteListingsIds: favoriteListingsIds,
    );
  }

  Future<List<Object>> getAuthentificationCode({required String email}) async {
    final authentificationCode = await _userSource.getAuthentificationCode(email: email);
    return authentificationCode;
  }

  Future<void> addListingToFavorites({required String id}) async {
    final user = await getLoggedUser();

    if (!user.favoriteListingsIds.contains(id)) {
      await updateUser(favoriteListingsIds: [...user.favoriteListingsIds, id]);
      await _userRepository.invalidateCache(additionalParam: user.id);
    }
  }

  Future<void> removeListingToFavorites({required String id}) async {
    final user = await getLoggedUser();
    List<String> newFavoriteListingsIds = [];

    if (user.favoriteListingsIds.contains(id)) {
      newFavoriteListingsIds = user.favoriteListingsIds;
      newFavoriteListingsIds.remove(id);
      await updateUser(favoriteListingsIds: newFavoriteListingsIds);
      await _userRepository.invalidateCache(additionalParam: user.id);
    }
  }
}
