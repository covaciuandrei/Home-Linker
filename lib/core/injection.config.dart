// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i3;
import '../cubit/introductive/introductive_cubit.dart' as _i4;
import '../cubit/login/login_cubit.dart' as _i5;
import '../cubit/new_property/new_property_cubit.dart' as _i6;
import '../cubit/profile/profile_cubit.dart' as _i7;
import '../cubit/property/property_cubit.dart' as _i8;
import '../cubit/settings/settings_cubit.dart' as _i9;
import '../cubit/signup/signup_cubit.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.HomeCubit>(() => _i3.HomeCubit());
  gh.factory<_i4.IntroductiveCubit>(() => _i4.IntroductiveCubit());
  gh.factory<_i5.LoginCubit>(() => _i5.LoginCubit());
  gh.factory<_i6.NewPropertyCubit>(() => _i6.NewPropertyCubit());
  gh.factory<_i7.ProfileCubit>(() => _i7.ProfileCubit());
  gh.factory<_i8.PropertyCubit>(() => _i8.PropertyCubit());
  gh.factory<_i9.SettingsCubit>(() => _i9.SettingsCubit());
  gh.factory<_i10.SignupCubit>(() => _i10.SignupCubit());
  return getIt;
}
