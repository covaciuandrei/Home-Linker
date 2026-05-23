import 'dart:convert';

import 'package:homelinker/data/database/database.dart';
import 'package:homelinker/data/database/expiration_time.dart';
import 'package:homelinker/data/mappers/user_mapper.dart';
import 'package:homelinker/data/repository/base_repository.dart';
import 'package:homelinker/models/user.dart' as model;
import 'package:injectable/injectable.dart';

@injectable
class UserRepository extends BaseRepository {
  UserRepository(this._userMapper, super.databaseProvider);

  final UserMapper _userMapper;

  @override
  int get cachePeriod => ExpirationTimesConstants.longTermTable;

  @override
  String get tableName => database.users.tableName!;

  Future<model.User> get(String id) async {
    final user = (await (database.select(database.users)..where((tbl) => tbl.id.equals(id))).get())[0];
    return _userMapper.mapUserFromDatabase(user);
  }

  Future<void> insert({required List<model.User> users}) async {
    for (final user in users) {
      final companion = UsersCompanion.insert(
        email: user.email,
        is2FaActivated: user.is2FaActivated,
        phone: user.phone,
        profilePictureId: user.profilePictureId,
        id: user.id,
        type: user.type.name,
        name: user.name,
        twoFactorAuthCode: user.twoFactorAuthCode,
        favoriteListingsIds: jsonEncode(user.favoriteListingsIds),
      );
      await database.into(database.users).insert(companion);
    }

    return setLastUpdateNow(additionalParam: users[0].id);
  }

  Future<void> clear({required String userId}) async {
    await (database.delete(database.users)..where((t) => t.id.equals(userId))).go();
  }
}
