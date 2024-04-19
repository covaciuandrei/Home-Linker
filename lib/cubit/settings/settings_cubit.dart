import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/services/account/account_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/settings/settings_states.dart';

@injectable
class SettingsCubit extends BaseCubit {
  SettingsCubit(
    this._accountService,
    this._userService,
  ) : super(InitialState());

  final AccountService _accountService;
  final UserService _userService;
  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 400), () => safeEmit(PageLoadedState()));
  }

  Future<void> deleteAccount() async {
    safeEmit(PendingState());
    try {
      await _accountService.deleteAccount();

      await _userService.deleteAccount();
      Future.delayed(const Duration(milliseconds: 50),
          () => safeEmit(AccountDeletedSuccessfullyState()));
    } catch (e) {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<void> logOut() async {
    safeEmit(PendingState());
    try {
      await _accountService.logout();
      safeEmit(LoggedOutSuccessfullyState());
    } catch (e) {
      safeEmit(SomethingWentWrongState());
    }
  }
}
