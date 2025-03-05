import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/user_mapper.dart';
import 'package:homelinker/data/remote/user/user_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserSource {
  UserSource(
    this._userMapper,
  );
  final UserMapper _userMapper;

  CollectionReference<UserDto> get _collectionRef =>
      FirebaseFirestore.instance.collection(RemoteSourceNames.users).withConverter<UserDto>(
            fromFirestore: (snapshots, _) => UserDto.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<User> get(String email) async {
    final querySnapshot = await _collectionRef.where('email', isEqualTo: email.toLowerCase()).limit(1).get();
    if (querySnapshot.docs.isEmpty) {}
    final userDto = querySnapshot.docs.map((doc) => doc.data()).single;
    final userId = querySnapshot.docs.first.id;
    return _userMapper.mapUserDto(userDto, userId);
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String phoneNumber,
    required AccountType accountType,
  }) async {
    final userDto = UserDto(
      email,
      false,
      name,
      phoneNumber,
      '',
      accountType.name,
      '',
      [],
    );

    await _collectionRef.add(userDto);
  }

  Future<User> getUserByUsername(String username) async {
    final querySnapshot = await _collectionRef.where('email', isEqualTo: username.toLowerCase()).limit(1).get();
    final userDto = querySnapshot.docs.map((doc) => doc.data()).single;
    final userId = querySnapshot.docs.first.id;

    return _userMapper.mapUserDto(userDto, userId);
  }

  Future<void> deleteAccount(String userId) async {
    final documentSnapshot = await _collectionRef.doc(userId).get();
    final documentReference = documentSnapshot.reference;
    await documentReference.delete();
  }

  Future<void> updateUser({
    required String userId,
    String? imageId,
    List<String>? favoriteListingsIds,
  }) async {
    final documentSnapshot = await _collectionRef.doc(userId).get();
    final documentReference = documentSnapshot.reference;

    final Map<String, dynamic> dataToUpdate = {};
    if (imageId != null) {
      dataToUpdate['profile_picture'] = imageId;
    }

    if (favoriteListingsIds != null) {
      dataToUpdate['favorite_listings_ids'] = favoriteListingsIds;
    }

    if (dataToUpdate.isNotEmpty) {
      await documentReference.update(dataToUpdate);
    }
  }

  Future<bool> set2FactorAuthCode({required String email, required String code}) async {
    final querySnapshot = await _collectionRef.where('email', isEqualTo: email.toLowerCase()).limit(1).get();
    // final userDto = querySnapshot.docs.map((doc) => doc.data()).single;
    if (querySnapshot.docs.isEmpty) {
      return false;
    }
    final userId = querySnapshot.docs.first.id;

    final documentReference = _collectionRef.doc(userId);
    final Map<String, dynamic> dataToUpdate = {};
    dataToUpdate['two_factor_auth_code'] = code;
    try {
      if (dataToUpdate.isNotEmpty) {
        await documentReference.update(dataToUpdate);
        print('cod setat');
        return true;
      }
    } catch (e) {
      print(e);
      print('cod nesetat');
      return false;
    }
    return false;
  }

  Future<List<Object>> getAuthentificationCode({required String email}) async {
    final querySnapshot = await _collectionRef.where('email', isEqualTo: email.toLowerCase()).limit(1).get();

    if (querySnapshot.docs.isEmpty) {
      return ['', false];
    }

    final user = await getUserByUsername(email);
    final code = user.twoFactorAuthCode;

    return [code, true];
  }
}
