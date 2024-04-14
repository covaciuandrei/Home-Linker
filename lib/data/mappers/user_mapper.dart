import 'package:homelinker/data/remote/user/user_dto.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserMapper {
  User mapUserDto(UserDto dto, String id) => User(
        email: dto.email,
        name: dto.name,
        phone: dto.phone,
        profilePicturePath: dto.profilePicturePath,
        type: AccountType.values.byName(dto.type),
      );
}
