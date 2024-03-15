import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/settings/settings_states.dart';

@injectable
class SettingsCubit extends BaseCubit {
  SettingsCubit() : super(InitialState());

  Future<void> deleteAccount() async {
    safeEmit(PendingState());
    try {
      //_accountService.deleteAccount();
      Future.delayed(const Duration(milliseconds: 50),
          () => safeEmit(AccountDeletedSuccessfullyState()));
    } catch (e) {
      safeEmit(SomethingWentWrongState());
    }
  }
}
