import 'package:homelinker/models/enums/account_type.dart';

class User {
  User({
    required this.email,
    required this.name,
    required this.phone,
    required this.profilePicturePath,
    required this.type,
  });

  final String email;
  final String name;
  final String phone;
  final String profilePicturePath;
  final AccountType type;
}
