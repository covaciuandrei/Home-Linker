import 'dart:io';

import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/new_property/new_property_states.dart';

@injectable
class NewPropertyCubit extends BaseCubit {
  NewPropertyCubit() : super(InitialState());

  Future<File?> uploadImage() async {
    safeEmit(PendingState());

    Future.delayed(const Duration(milliseconds: 50),
        () => safeEmit(ImageUploadedSuccessfullyState()));
    return File('');
  }
}
