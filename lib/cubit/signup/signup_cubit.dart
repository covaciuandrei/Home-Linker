import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
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

  @override
  void onChange(Change<BaseState> change) {
    print('State changed: ${change.currentState} -> ${change.nextState}');
    super.onChange(change);
  }

  void loadPage() {
    safeEmit(PageLoadedState());
  }

  Future<void> createAccount(
      {required String email, required String password}) async {
    try {
      safeEmit(PendingState());
      await _accountService.createAccount(email: email, password: password);
      safeEmit(SignUpSuccessfullyState());
    } on Exception {
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
      safeEmit(InputsErrorState());
    }
  }

  void login() {
    safeEmit(NavigateToLoginState());
  }

  void back() {
    safeEmit(NavigateToIntroductiveState());
  }
}
