import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/remote/user/user_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserSource {
  UserSource(
      // this._userMapper,
      );
  // final UserMapper _userMapper;

  CollectionReference<UserDto> get _collectionRef => FirebaseFirestore.instance
      .collection(RemoteSourceNames.users)
      .withConverter<UserDto>(
        fromFirestore: (snapshots, _) => UserDto.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<void> createUser({
    required String email,
    required String name,
    required String phoneNumber,
    required AccountType accountType,
  }) async {
    final userDto = UserDto(
      email,
      name,
      phoneNumber,
      '',
      accountType.name,
    );

    await _collectionRef.add(userDto);
  }
}
