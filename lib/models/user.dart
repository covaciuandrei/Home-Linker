import 'package:equatable/equatable.dart';
import 'package:homelinker/models/enums/account_type.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.profilePictureId,
    required this.type,
    required this.is2FaActivated,
    required this.twoFactorAuthCode,
    required this.favoriteListingsIds,
  });

  final String id;
  final String email;
  final String name;
  final String phone;
  final String profilePictureId;
  final AccountType type;
  final bool is2FaActivated;
  final String twoFactorAuthCode;
  final List<String> favoriteListingsIds;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        profilePictureId,
        type,
        is2FaActivated,
        twoFactorAuthCode,
        ...favoriteListingsIds,
      ];
}
