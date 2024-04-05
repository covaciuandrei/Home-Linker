import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/validator_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/signup/signup_states.dart';

@injectable
class SignupCubit extends BaseCubit {
  SignupCubit(this._accountService, this._validatorService)
      : super(InitialState());

  final AccountService _accountService;
  final ValidatorService _validatorService;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isNameValid = false;
  bool _isPhoneValid = false;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 200), () => safeEmit(PageLoadedState()));
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required AccountType accountType,
  }) async {
    try {
      safeEmit(PendingState());

      await _accountService.createAccount(
        email: email,
        password: password,
        accountType: accountType,
        name: name,
        phoneNumber: phoneNumber,
      );
      safeEmit(SignUpSuccessfullyState());
    } on Exception catch (e) {
      print(e);
      print('error la create acc');
    }
  }

  void checkEmailValidity(String email) {
    bool isEmailValid = _validatorService.checkEmailValidity(email);
    if (email.isEmpty) {
      _isEmailValid = false;
    } else if (!isEmailValid) {
      _isEmailValid = false;
    } else {
      _isEmailValid = true;
    }
    _checkCreateAccountValidity();
  }

  void checkPasswordValidity(String firstPassword, String secondPassword) {
    bool isPasswordValid =
        _validatorService.checkPasswordValidity(firstPassword, secondPassword);

    if (firstPassword.isEmpty || secondPassword.isEmpty) {
      _isPasswordValid = false;
    } else if (!isPasswordValid) {
      _isPasswordValid = false;
    } else {
      _isPasswordValid = true;
    }
    _checkCreateAccountValidity();
  }

  void _checkCreateAccountValidity() {
    if (_isPasswordValid && _isEmailValid) {
      safeEmit(RightInputState());
    } else {
      safeEmit(InputErrorState());
    }
  }

  void goToLogin() {
    safeEmit(NavigateToLoginState());
  }

  void goBack() {
    safeEmit(NavigateToIntroductiveState());
  }

  void checkPhoneValidity(String phoneNumber) {
    _isPhoneValid = _validatorService.checkPhoneValidity(phoneNumber);

    _checkNameAndPhoneValidity();
  }

  void checkNameValidity(String text) {
    _isNameValid = text.isEmpty ? false : true;

    _checkNameAndPhoneValidity();
  }

  void _checkNameAndPhoneValidity() {
    if (_isPhoneValid && _isNameValid) {
      safeEmit(RightInputState());
    } else {
      safeEmit(InputErrorState());
    }
  }

  void goToSecondSignupPage() {
    safeEmit(PendingState());

    safeEmit(SecondSignupState());
  }
}
