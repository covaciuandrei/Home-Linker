import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/property/property_states.dart';

@injectable
class PropertyCubit extends BaseCubit {
  PropertyCubit() : super(InitialState());

  Future<void> load() async {
    safeEmit(PendingState());

    Future.delayed(const Duration(milliseconds: 50),
        () => safeEmit(PropertyLoadedState()));
  }
}
