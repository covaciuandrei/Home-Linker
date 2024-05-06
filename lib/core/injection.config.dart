// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i25;
import '../cubit/introductive/introductive_cubit.dart' as _i7;
import '../cubit/listing/listing_cubit.dart' as _i26;
import '../cubit/login/login_cubit.dart' as _i27;
import '../cubit/new_property/new_property_cubit.dart' as _i28;
import '../cubit/profile/profile_cubit.dart' as _i29;
import '../cubit/property/property_cubit.dart' as _i8;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i24;
import '../cubit/reset_password/reset_password_cubit.dart' as _i11;
import '../cubit/settings/settings_cubit.dart' as _i30;
import '../cubit/signup/signup_cubit.dart' as _i31;
import '../cubit/splash/splash_cubit.dart' as _i13;
import '../data/mappers/app_version_mapper.dart' as _i3;
import '../data/mappers/image_mapper.dart' as _i5;
import '../data/mappers/property_mapper.dart' as _i9;
import '../data/mappers/user_mapper.dart' as _i15;
import '../data/remote/app_version/app_version_source.dart' as _i4;
import '../data/remote/image/image_source.dart' as _i6;
import '../data/remote/property/property_source.dart' as _i10;
import '../data/remote/storage/storage_source.dart' as _i14;
import '../data/remote/user/user_source.dart' as _i16;
import '../data/secure_storage/secure_storage_source.dart' as _i12;
import '../services/account/account_service.dart' as _i22;
import '../services/app_version/app_version_service.dart' as _i18;
import '../services/file/file_service.dart' as _i23;
import '../services/image/image_service.dart' as _i19;
import '../services/property/property_service.dart' as _i20;
import '../services/user/user_service.dart' as _i21;
import '../services/validator_service.dart' as _i17;

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
  gh.factory<_i3.AppVersionMapper>(() => _i3.AppVersionMapper());
  gh.factory<_i4.AppVersionSource>(
      () => _i4.AppVersionSource(gh<_i3.AppVersionMapper>()));
  gh.factory<_i5.ImageMapper>(() => _i5.ImageMapper());
  gh.factory<_i6.ImagesSource>(() => _i6.ImagesSource(gh<_i5.ImageMapper>()));
  gh.factory<_i7.IntroductiveCubit>(() => _i7.IntroductiveCubit());
  gh.factory<_i8.PropertyCubit>(() => _i8.PropertyCubit());
  gh.factory<_i9.PropertyMapper>(() => _i9.PropertyMapper());
  gh.factory<_i10.PropertySource>(
      () => _i10.PropertySource(gh<_i9.PropertyMapper>()));
  gh.factory<_i11.ResetPasswordCubit>(() => _i11.ResetPasswordCubit());
  gh.factory<_i12.SecureStorageSource>(() => _i12.SecureStorageSource());
  gh.factory<_i13.SplashCubit>(() => _i13.SplashCubit());
  gh.factory<_i14.StorageSource>(() => _i14.StorageSource());
  gh.factory<_i15.UserMapper>(() => _i15.UserMapper());
  gh.factory<_i16.UserSource>(() => _i16.UserSource(gh<_i15.UserMapper>()));
  gh.factory<_i17.ValidatorService>(() => _i17.ValidatorService());
  gh.factory<_i18.AppVersionService>(
      () => _i18.AppVersionService(gh<_i4.AppVersionSource>()));
  gh.factory<_i19.ImageService>(() => _i19.ImageService(
        gh<_i6.ImagesSource>(),
        gh<_i14.StorageSource>(),
      ));
  gh.factory<_i20.PropertyService>(
      () => _i20.PropertyService(gh<_i10.PropertySource>()));
  gh.factory<_i21.UserService>(() => _i21.UserService(
        gh<_i16.UserSource>(),
        gh<_i12.SecureStorageSource>(),
      ));
  gh.factory<_i22.AccountService>(() => _i22.AccountService(
        gh<_i12.SecureStorageSource>(),
        gh<_i21.UserService>(),
        gh<_i16.UserSource>(),
      ));
  gh.factory<_i23.FileService>(() => _i23.FileService(
        gh<_i14.StorageSource>(),
        gh<_i21.UserService>(),
        gh<_i6.ImagesSource>(),
      ));
  gh.factory<_i24.ForgotPasswordCubit>(
      () => _i24.ForgotPasswordCubit(gh<_i22.AccountService>()));
  gh.factory<_i25.HomeCubit>(() => _i25.HomeCubit(
        gh<_i20.PropertyService>(),
        gh<_i19.ImageService>(),
      ));
  gh.factory<_i26.ListingCubit>(() => _i26.ListingCubit(
        gh<_i20.PropertyService>(),
        gh<_i19.ImageService>(),
      ));
  gh.factory<_i27.LoginCubit>(() => _i27.LoginCubit(
        gh<_i22.AccountService>(),
        gh<_i17.ValidatorService>(),
      ));
  gh.factory<_i28.NewPropertyCubit>(() => _i28.NewPropertyCubit(
        gh<_i20.PropertyService>(),
        gh<_i21.UserService>(),
        gh<_i23.FileService>(),
      ));
  gh.factory<_i29.ProfileCubit>(() => _i29.ProfileCubit(
        gh<_i23.FileService>(),
        gh<_i21.UserService>(),
        gh<_i19.ImageService>(),
        gh<_i18.AppVersionService>(),
      ));
  gh.factory<_i30.SettingsCubit>(() => _i30.SettingsCubit(
        gh<_i22.AccountService>(),
        gh<_i21.UserService>(),
        gh<_i18.AppVersionService>(),
      ));
  gh.factory<_i31.SignupCubit>(() => _i31.SignupCubit(
        gh<_i22.AccountService>(),
        gh<_i17.ValidatorService>(),
      ));
  return getIt;
}
