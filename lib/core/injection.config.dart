// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i27;
import '../cubit/introductive/introductive_cubit.dart' as _i4;
import '../cubit/login/login_cubit.dart' as _i22;
import '../cubit/new_property/new_property_cubit.dart' as _i23;
import '../cubit/profile/profile_cubit.dart' as _i5;
import '../cubit/property/property_cubit.dart' as _i6;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i20;
import '../cubit/reset_password/reset_password_cubit.dart' as _i24;
import '../cubit/settings/settings_cubit.dart' as _i25;
import '../cubit/signup/signup_cubit.dart' as _i26;
import '../cubit/splash/splash_cubit.dart' as _i10;
import '../data/mappers/image_mapper.dart' as _i3;
import '../data/mappers/property_mapper.dart' as _i7;
import '../data/mappers/user_mapper.dart' as _i12;
import '../data/remote/image/image_source.dart' as _i15;
import '../data/remote/property/property_source.dart' as _i8;
import '../data/remote/storage/storage_source.dart' as _i11;
import '../data/remote/user/user_source.dart' as _i13;
import '../data/secure_storage/secure_storage_source.dart' as _i9;
import '../services/account/account_service.dart' as _i18;
import '../services/file/file_service.dart' as _i19;
import '../services/image/image_service.dart' as _i21;
import '../services/property/property_service.dart' as _i16;
import '../services/user/user_service.dart' as _i17;
import '../services/validator_service.dart' as _i14;

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
  gh.factory<_i3.ImageMapper>(() => _i3.ImageMapper());
  gh.factory<_i4.IntroductiveCubit>(() => _i4.IntroductiveCubit());
  gh.factory<_i5.ProfileCubit>(() => _i5.ProfileCubit());
  gh.factory<_i6.PropertyCubit>(() => _i6.PropertyCubit());
  gh.factory<_i7.PropertyMapper>(() => _i7.PropertyMapper());
  gh.factory<_i8.PropertySource>(
      () => _i8.PropertySource(gh<_i7.PropertyMapper>()));
  gh.factory<_i9.SecureStorageSource>(() => _i9.SecureStorageSource());
  gh.factory<_i10.SplashCubit>(() => _i10.SplashCubit());
  gh.factory<_i11.StorageSource>(() => _i11.StorageSource());
  gh.factory<_i12.UserMapper>(() => _i12.UserMapper());
  gh.factory<_i13.UserSource>(() => _i13.UserSource(gh<_i12.UserMapper>()));
  gh.factory<_i14.ValidatorService>(() => _i14.ValidatorService());
  gh.factory<_i15.ImagesSource>(() => _i15.ImagesSource(
        gh<_i3.ImageMapper>(),
        gh<_i11.StorageSource>(),
      ));
  gh.factory<_i16.PropertyService>(
      () => _i16.PropertyService(gh<_i8.PropertySource>()));
  gh.factory<_i17.UserService>(() => _i17.UserService(
        gh<_i13.UserSource>(),
        gh<_i9.SecureStorageSource>(),
      ));
  gh.factory<_i18.AccountService>(() => _i18.AccountService(
        gh<_i9.SecureStorageSource>(),
        gh<_i17.UserService>(),
      ));
  gh.factory<_i19.FileService>(() => _i19.FileService(
        gh<_i11.StorageSource>(),
        gh<_i17.UserService>(),
        gh<_i15.ImagesSource>(),
      ));
  gh.factory<_i20.ForgotPasswordCubit>(
      () => _i20.ForgotPasswordCubit(gh<_i18.AccountService>()));
  gh.factory<_i21.ImageService>(() => _i21.ImageService(
        gh<_i15.ImagesSource>(),
        gh<_i11.StorageSource>(),
      ));
  gh.factory<_i22.LoginCubit>(() => _i22.LoginCubit(
        gh<_i18.AccountService>(),
        gh<_i14.ValidatorService>(),
      ));
  gh.factory<_i23.NewPropertyCubit>(() => _i23.NewPropertyCubit(
        gh<_i16.PropertyService>(),
        gh<_i17.UserService>(),
        gh<_i19.FileService>(),
      ));
  gh.factory<_i24.ResetPasswordCubit>(
      () => _i24.ResetPasswordCubit(gh<_i18.AccountService>()));
  gh.factory<_i25.SettingsCubit>(
      () => _i25.SettingsCubit(gh<_i18.AccountService>()));
  gh.factory<_i26.SignupCubit>(() => _i26.SignupCubit(
        gh<_i18.AccountService>(),
        gh<_i14.ValidatorService>(),
      ));
  gh.factory<_i27.HomeCubit>(() => _i27.HomeCubit(
        gh<_i16.PropertyService>(),
        gh<_i21.ImageService>(),
      ));
  return getIt;
}
