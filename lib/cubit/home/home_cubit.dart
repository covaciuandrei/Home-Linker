import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/home/home_states.dart';

@injectable
class HomeCubit extends BaseCubit {
  HomeCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());
    Future.delayed(
        const Duration(seconds: 1), () => safeEmit(DataLoadedState()));
  }
}
