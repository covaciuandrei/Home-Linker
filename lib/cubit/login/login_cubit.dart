import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/login/login_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseCubit {
  LoginCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 50),
        () => safeEmit(LoadingFinishedState()));
  }
}
