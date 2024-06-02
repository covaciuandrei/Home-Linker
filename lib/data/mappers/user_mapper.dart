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
      );
}
