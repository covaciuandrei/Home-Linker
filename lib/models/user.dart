import 'package:homelinker/models/enums/account_type.dart';

class User {
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.profilePictureId,
    required this.type,
    required this.is2FaActivated,
  });

  final String id;
  final String email;
  final String name;
  final String phone;
  final String profilePictureId;
  final AccountType type;
  final bool is2FaActivated;
}
