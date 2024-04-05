import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/introductive/introductive_states.dart';

@injectable
class IntroductiveCubit extends BaseCubit {
  IntroductiveCubit() : super(InitialState());
  void onChange(Change<BaseState> change) {
    print('State changed: ${change.currentState} -> ${change.nextState}');
    super.onChange(change);
  }

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
