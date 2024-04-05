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
import '../cubit/login/login_cubit.dart' as _i13;
import '../cubit/new_property/new_property_cubit.dart' as _i5;
import '../cubit/profile/profile_cubit.dart' as _i6;
import '../cubit/property/property_cubit.dart' as _i7;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i12;
import '../cubit/reset_password/reset_password_cubit.dart' as _i14;
import '../cubit/settings/settings_cubit.dart' as _i15;
import '../cubit/signup/signup_cubit.dart' as _i16;
import '../cubit/splash/splash_cubit.dart' as _i9;
import '../data/secure_storage_source.dart' as _i8;
import '../services/account/account_service.dart' as _i11;
import '../services/validator_service.dart' as _i10;

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
  gh.factory<_i5.NewPropertyCubit>(() => _i5.NewPropertyCubit());
  gh.factory<_i6.ProfileCubit>(() => _i6.ProfileCubit());
  gh.factory<_i7.PropertyCubit>(() => _i7.PropertyCubit());
  gh.factory<_i8.SecureStorageSource>(() => _i8.SecureStorageSource());
  gh.factory<_i9.SplashCubit>(() => _i9.SplashCubit());
  gh.factory<_i10.ValidatorService>(() => _i10.ValidatorService());
  gh.factory<_i11.AccountService>(
      () => _i11.AccountService(gh<_i8.SecureStorageSource>()));
  gh.factory<_i12.ForgotPasswordCubit>(
      () => _i12.ForgotPasswordCubit(gh<_i11.AccountService>()));
  gh.factory<_i13.LoginCubit>(() => _i13.LoginCubit(
        gh<_i11.AccountService>(),
        gh<_i10.ValidatorService>(),
      ));
  gh.factory<_i14.ResetPasswordCubit>(
      () => _i14.ResetPasswordCubit(gh<_i11.AccountService>()));
  gh.factory<_i15.SettingsCubit>(
      () => _i15.SettingsCubit(gh<_i11.AccountService>()));
  gh.factory<_i16.SignupCubit>(() => _i16.SignupCubit(
        gh<_i11.AccountService>(),
        gh<_i10.ValidatorService>(),
      ));
  return getIt;
}
