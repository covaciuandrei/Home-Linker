import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/reset_password/reset_password_states.dart';

@injectable
class ResetPasswordCubit extends BaseCubit {
  ResetPasswordCubit(this._accountService) : super(InitialState());
  final AccountService _accountService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    await Future.delayed(
        const Duration(milliseconds: 400), () => safeEmit(PageLoadedState()));
  }
}
