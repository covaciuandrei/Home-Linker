import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/validator_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/reset_password/forgot_password_states.dart';

@injectable
class ForgotPasswordCubit extends BaseCubit {
  ForgotPasswordCubit(
    this._accountService,
    this._validatorService,
  ) : super(InitialState());
  final AccountService _accountService;
  final ValidatorService _validatorService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    await Future.delayed(const Duration(milliseconds: 400), () => safeEmit(PageLoadedState()));
  }

  void checkEmailValidity(String email) {
    final isValid = email.isNotEmpty && _validatorService.checkEmailValidity(email);
    if (isValid) {
      safeEmit(RightInputState());
    } else {
      safeEmit(InputsErrorState());
    }
  }

  Future<void> resetPassword({required String email}) async {
    if (email.isEmpty || !_validatorService.checkEmailValidity(email)) {
      safeEmit(InvalidEmailState());
      return;
    }
    safeEmit(PendingState());
    try {
      await _accountService.forgotPassword(email: email);
      safeEmit(EmailSentSuccessfullyState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
