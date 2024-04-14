import 'package:firebase_auth/firebase_auth.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/validator_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/login/login_states.dart';

@injectable
class LoginCubit extends BaseCubit {
  LoginCubit(this._accountService, this._validatorService)
      : super(InitialState());
  final AccountService _accountService;
  final ValidatorService _validatorService;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    await Future.delayed(const Duration(milliseconds: 200),
        () => safeEmit(LoginPageLoadedState()));
  }

  Future<void> login({required String email, required String password}) async {
    try {
      safeEmit(PendingState());
      await _accountService.login(email: email, password: password);
      safeEmit(LoggedInSuccessfullyState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
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

  void checkPasswordValidity(String password) {
    _isPasswordValid = password.isNotEmpty;

    _checkCreateAccountValidity();
  }

  void _checkCreateAccountValidity() {
    if (_isPasswordValid && _isEmailValid) {
      safeEmit(RightInputState());
    } else {
      safeEmit(InputsErrorState());
    }
  }

  void goToSignup() {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 300));
    safeEmit(NavigateToSignupState());
  }

  void goBack() {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 300));
    safeEmit(NavigateToIntroductiveState());
  }

  void checkLoggedUser() {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
  }
}
