// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i19;
import '../cubit/introductive/introductive_cubit.dart' as _i3;
import '../cubit/login/login_cubit.dart' as _i14;
import '../cubit/new_property/new_property_cubit.dart' as _i20;
import '../cubit/profile/profile_cubit.dart' as _i4;
import '../cubit/property/property_cubit.dart' as _i5;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i13;
import '../cubit/reset_password/reset_password_cubit.dart' as _i16;
import '../cubit/settings/settings_cubit.dart' as _i17;
import '../cubit/signup/signup_cubit.dart' as _i18;
import '../cubit/splash/splash_cubit.dart' as _i9;
import '../data/mappers/property_mapper.dart' as _i6;
import '../data/remote/property/property_source.dart' as _i7;
import '../data/remote/user/user_source.dart' as _i10;
import '../data/secure_storage/secure_storage_source.dart' as _i8;
import '../services/account/account_service.dart' as _i12;
import '../services/property/property_service.dart' as _i15;
import '../services/validator_service.dart' as _i11;

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
  gh.factory<_i3.IntroductiveCubit>(() => _i3.IntroductiveCubit());
  gh.factory<_i4.ProfileCubit>(() => _i4.ProfileCubit());
  gh.factory<_i5.PropertyCubit>(() => _i5.PropertyCubit());
  gh.factory<_i6.PropertyMapper>(() => _i6.PropertyMapper());
  gh.factory<_i7.PropertySource>(
      () => _i7.PropertySource(gh<_i6.PropertyMapper>()));
  gh.factory<_i8.SecureStorageSource>(() => _i8.SecureStorageSource());
  gh.factory<_i9.SplashCubit>(() => _i9.SplashCubit());
  gh.factory<_i10.UserSource>(() => _i10.UserSource());
  gh.factory<_i11.ValidatorService>(() => _i11.ValidatorService());
  gh.factory<_i12.AccountService>(() => _i12.AccountService(
        gh<_i8.SecureStorageSource>(),
        gh<_i10.UserSource>(),
      ));
  gh.factory<_i13.ForgotPasswordCubit>(
      () => _i13.ForgotPasswordCubit(gh<_i12.AccountService>()));
  gh.factory<_i14.LoginCubit>(() => _i14.LoginCubit(
        gh<_i12.AccountService>(),
        gh<_i11.ValidatorService>(),
      ));
  gh.factory<_i15.PropertyService>(() => _i15.PropertyService(
        gh<_i7.PropertySource>(),
        gh<_i8.SecureStorageSource>(),
      ));
  gh.factory<_i16.ResetPasswordCubit>(
      () => _i16.ResetPasswordCubit(gh<_i12.AccountService>()));
  gh.factory<_i17.SettingsCubit>(
      () => _i17.SettingsCubit(gh<_i12.AccountService>()));
  gh.factory<_i18.SignupCubit>(() => _i18.SignupCubit(
        gh<_i12.AccountService>(),
        gh<_i11.ValidatorService>(),
      ));
  gh.factory<_i19.HomeCubit>(() => _i19.HomeCubit(gh<_i15.PropertyService>()));
  gh.factory<_i20.NewPropertyCubit>(
      () => _i20.NewPropertyCubit(gh<_i15.PropertyService>()));
  return getIt;
}
