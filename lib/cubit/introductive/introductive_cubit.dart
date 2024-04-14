import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/introductive/introductive_states.dart';

@injectable
class IntroductiveCubit extends BaseCubit {
  IntroductiveCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 100), () => safeEmit(PageLoadedState()));
  }

  void goToSignup() {
    safeEmit(PendingState());
    safeEmit(NavigateToSignupState());
  }

  void goToLogin() {
    safeEmit(PendingState());
    safeEmit(NavigateToLoginState());
  }
}
