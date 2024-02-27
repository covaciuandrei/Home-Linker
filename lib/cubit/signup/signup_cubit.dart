import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';

import 'package:injectable/injectable.dart';
part 'package:homelinker/cubit/signup/signup_states.dart';

@injectable
class SignupCubit extends BaseCubit {
  SignupCubit() : super(InitialState());

  Future<void> createAccount() async {
    safeEmit(PendingState());
    Future.delayed(const Duration(milliseconds: 50),
        () => safeEmit(SignUpSuccessfullyState()));
  }
}
