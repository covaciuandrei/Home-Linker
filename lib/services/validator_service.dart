import 'package:injectable/injectable.dart';

@injectable
class ValidatorService {
  bool checkEmailValidity(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool checkPasswordValidity(String firstPassword, String secondPassword) {
    return firstPassword == secondPassword;
  }
}
