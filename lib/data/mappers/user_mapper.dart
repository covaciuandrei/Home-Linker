import 'dart:convert';

import 'package:homelinker/data/database/database.dart' as database;
import 'package:homelinker/data/remote/user/user_dto.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserMapper {
  User mapUserDto(UserDto dto, String id) => User(
        id: id,
        email: dto.email,
        name: dto.name,
        phone: dto.phone,
        profilePictureId: dto.profilePictureId,
        type: AccountType.values.byName(dto.type),
        is2FaActivated: dto.is2FaActivated,
        twoFactorAuthCode: dto.twoFactorAuthCode,
        favoriteListingsIds: dto.favoriteListingsIds,
      );

  User mapUserFromDatabase(database.User dto) => User(
        email: dto.email,
        is2FaActivated: dto.is2FaActivated,
        phone: dto.phone,
        profilePictureId: dto.profilePictureId,
        id: dto.id,
        type: AccountType.values.byName(dto.type),
        name: dto.name,
        twoFactorAuthCode: dto.twoFactorAuthCode,
        favoriteListingsIds: _mapFavoriteListingsIdsFromDatabase(dto.favoriteListingsIds),
      );
}

List<String> _mapFavoriteListingsIdsFromDatabase(String? favListingsIds) {
  if (favListingsIds == null) {
    return [];
  }
  final jsonList = jsonDecode(favListingsIds);

  final desiredListings = <String>[];

  jsonList.forEach(desiredListings.add);

  return desiredListings;
}
