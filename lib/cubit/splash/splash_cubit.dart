import 'package:firebase_auth/firebase_auth.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/splash/splash_states.dart';

@injectable
class SplashCubit extends BaseCubit {
  SplashCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    final user = FirebaseAuth.instance.currentUser;
    print(user);

    safeEmit(user == null ? NoUserFoundState() : UserLoggedInState());
  }
}
