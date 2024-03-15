import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/profile/profile_states.dart';

@injectable
class ProfileCubit extends BaseCubit {
  ProfileCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 50), () => safeEmit(ProfileLoadedState()));
  }
}
