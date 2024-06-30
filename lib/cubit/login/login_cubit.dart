import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:homelinker/services/validator_service.dart';
import 'package:injectable/injectable.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

part 'package:homelinker/cubit/login/login_states.dart';

@injectable
class LoginCubit extends BaseCubit {
  LoginCubit(this._accountService, this._validatorService, this._userService) : super(InitialState());
  final AccountService _accountService;
  final ValidatorService _validatorService;
  final UserService _userService;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    await Future.delayed(const Duration(milliseconds: 200), () => safeEmit(LoginPageLoadedState()));
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

  Future<bool> sendEmail({required String email}) async {
    String username = 'etticov@gmail.com';
    String password = 'zcem asev carz rnie';

    final smtpServer = gmail(username, password);
    final code = generateRandom4DigitCode();
    final message = Message()
      ..from = Address(username, 'HomeLinker')
      ..recipients.add(email)
      ..subject = 'Code for authentication'
      ..text = 'Your authentification code is $code';

    try {
      // final sendReport =
      await send(message, smtpServer);

      final wasCodeSent = await _userService.set2FactorAuthCode(email: email, code: code);
      print(code);
      // print('Message sent: ' + sendReport.toString());
      print('Message sent.');
      return wasCodeSent;
    } on Exception {
      print('Message not sent.');

      return false;
    }
  }

  String generateRandom4DigitCode() {
    var random = Random();
    var code = random.nextInt(9000) + 1000;
    return code.toString();
  }

  Future<bool> verifyCodeAndLogin({
    required String code,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final authentificationData = await _userService.getAuthentificationCode(email: email);
    final cloudCode = authentificationData[0];
    final existsUser = authentificationData[1] as bool;
    if (existsUser) {
      print('cod corect');
      if (code == cloudCode) {
        await login(email: email, password: password);
        return true;
      } else {
        print('cod incorect');
        return false;
      }
    } else {
      print('user doesn\'t exist.');

      return false;
    }
  }
}
