import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:homelinker/services/validator_service.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> login({required String email, required String password, required BuildContext context}) async {
    try {
      safeEmit(PendingState());
      await _accountService.login(email: email, password: password, context: context);
      final user = await _userService.getLoggedUser();
      safeEmit(LoggedInSuccessfullyState());
      // if (user.is2FaActivated) {

      // } else {
      //   enrollMFA(user.phone, context);
      // }
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

  void enrollMFA(String phoneNumber, BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Automatically called when the SMS code is auto-retrieved or the phone number is instantly verified.
        auth.currentUser!.updatePhoneNumber(credential).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Phone number automatically verified and updated")),
          );
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle errors, such as invalid phone numbers or SMS quota reached.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to verify phone number: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        final TextEditingController controller = TextEditingController();
        // This callback is called after the SMS message has been sent.
        // Prompt the user to enter the SMS code.
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Enter SMS Code"),
              content: TextField(
                controller: controller,
                onChanged: (value) {
                  // Optionally, store the user-entered code.
                },
              ),
              actions: [
                TextButton(
                  child: Text("Confirm"),
                  onPressed: () {
                    try {
                      verifyPhoneNumber(controller.text, verificationId, context);
                    } catch (e) {
                      print('plm nu merge');
                    }

                    AutoRouter.of(context).popForced();
                    // You'll typically want to bind this logic to a function.
                  },
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout.
      },
    );
  }

  void verifyPhoneNumber(String smsCode, String verificationId, BuildContext context) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    // Sign in with the credential
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser?.linkWithCredential(phoneAuthCredential).then((userCredential) {
        safeEmit(LoggedInSuccessfullyState());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logged in successfully!")),
        );
      }).catchError((error) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to verify code, please try to log in again")),
        );
        await _accountService.logout();
        safeEmit(LoginErrorState());
      });
    } else {
      AutoRouter.of(context).popForced();
    }
  }
}
