import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/reset_password/forgot_password_states.dart';

@injectable
class ForgotPasswordCubit extends BaseCubit {
  ForgotPasswordCubit(this._accountService) : super(InitialState());
  final AccountService _accountService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    await Future.delayed(
        const Duration(milliseconds: 400), () => safeEmit(PageLoadedState()));
  }

  Future<void> resetPassword({required String email}) async {
    safeEmit(PendingState());
    try {
      await _accountService.forgotPassword(email: email);
      safeEmit(EmailSentSuccessfullyState());
    } catch (e) {
      safeEmit(SomethingWentWrongState());
      print(e);
    }
  }
}
