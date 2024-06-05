// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i26;
import '../cubit/introductive/introductive_cubit.dart' as _i8;
import '../cubit/listing/listing_cubit.dart' as _i27;
import '../cubit/login/login_cubit.dart' as _i28;
import '../cubit/new_property/new_property_cubit.dart' as _i29;
import '../cubit/profile/profile_cubit.dart' as _i30;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i25;
import '../cubit/reset_password/reset_password_cubit.dart' as _i11;
import '../cubit/settings/settings_cubit.dart' as _i31;
import '../cubit/signup/signup_cubit.dart' as _i32;
import '../cubit/splash/splash_cubit.dart' as _i13;
import '../data/database/database_provider.dart' as _i5;
import '../data/mappers/app_version_mapper.dart' as _i3;
import '../data/mappers/image_mapper.dart' as _i6;
import '../data/mappers/property_mapper.dart' as _i9;
import '../data/mappers/user_mapper.dart' as _i15;
import '../data/remote/app_version/app_version_source.dart' as _i4;
import '../data/remote/image/image_source.dart' as _i7;
import '../data/remote/property/property_source.dart' as _i10;
import '../data/remote/storage/storage_source.dart' as _i14;
import '../data/remote/user/user_source.dart' as _i17;
import '../data/repository/user_repository.dart' as _i16;
import '../data/secure_storage/secure_storage_source.dart' as _i12;
import '../services/account/account_service.dart' as _i23;
import '../services/app_version/app_version_service.dart' as _i19;
import '../services/file/file_service.dart' as _i24;
import '../services/image/image_service.dart' as _i20;
import '../services/property/property_service.dart' as _i21;
import '../services/user/user_service.dart' as _i22;
import '../services/validator_service.dart' as _i18;

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
  gh.singleton<_i5.DatabaseProvider>(() => _i5.DatabaseProvider());
  gh.factory<_i6.ImageMapper>(() => _i6.ImageMapper());
  gh.factory<_i7.ImagesSource>(() => _i7.ImagesSource(gh<_i6.ImageMapper>()));
  gh.factory<_i8.IntroductiveCubit>(() => _i8.IntroductiveCubit());
  gh.factory<_i9.PropertyMapper>(() => _i9.PropertyMapper());
  gh.factory<_i10.PropertySource>(
      () => _i10.PropertySource(gh<_i9.PropertyMapper>()));
  gh.factory<_i11.ResetPasswordCubit>(() => _i11.ResetPasswordCubit());
  gh.factory<_i12.SecureStorageSource>(() => _i12.SecureStorageSource());
  gh.factory<_i13.SplashCubit>(() => _i13.SplashCubit());
  gh.factory<_i14.StorageSource>(() => _i14.StorageSource());
  gh.factory<_i15.UserMapper>(() => _i15.UserMapper());
  gh.factory<_i16.UserRepository>(() => _i16.UserRepository(
        gh<_i15.UserMapper>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i17.UserSource>(() => _i17.UserSource(gh<_i15.UserMapper>()));
  gh.factory<_i18.ValidatorService>(() => _i18.ValidatorService());
  gh.factory<_i19.AppVersionService>(
      () => _i19.AppVersionService(gh<_i4.AppVersionSource>()));
  gh.factory<_i20.ImageService>(() => _i20.ImageService(
        gh<_i7.ImagesSource>(),
        gh<_i14.StorageSource>(),
      ));
  gh.factory<_i21.PropertyService>(
      () => _i21.PropertyService(gh<_i10.PropertySource>()));
  gh.factory<_i22.UserService>(() => _i22.UserService(
        gh<_i17.UserSource>(),
        gh<_i12.SecureStorageSource>(),
        gh<_i16.UserRepository>(),
      ));
  gh.factory<_i23.AccountService>(() => _i23.AccountService(
        gh<_i12.SecureStorageSource>(),
        gh<_i22.UserService>(),
        gh<_i17.UserSource>(),
      ));
  gh.factory<_i24.FileService>(() => _i24.FileService(
        gh<_i14.StorageSource>(),
        gh<_i22.UserService>(),
        gh<_i7.ImagesSource>(),
      ));
  gh.factory<_i25.ForgotPasswordCubit>(
      () => _i25.ForgotPasswordCubit(gh<_i23.AccountService>()));
  gh.factory<_i26.HomeCubit>(() => _i26.HomeCubit(
        gh<_i21.PropertyService>(),
        gh<_i20.ImageService>(),
      ));
  gh.factory<_i27.ListingCubit>(() => _i27.ListingCubit(
        gh<_i21.PropertyService>(),
        gh<_i20.ImageService>(),
      ));
  gh.factory<_i28.LoginCubit>(() => _i28.LoginCubit(
        gh<_i23.AccountService>(),
        gh<_i18.ValidatorService>(),
        gh<_i22.UserService>(),
      ));
  gh.factory<_i29.NewPropertyCubit>(() => _i29.NewPropertyCubit(
        gh<_i21.PropertyService>(),
        gh<_i22.UserService>(),
        gh<_i24.FileService>(),
      ));
  gh.factory<_i30.ProfileCubit>(() => _i30.ProfileCubit(
        gh<_i24.FileService>(),
        gh<_i22.UserService>(),
        gh<_i20.ImageService>(),
        gh<_i19.AppVersionService>(),
      ));
  gh.factory<_i31.SettingsCubit>(() => _i31.SettingsCubit(
        gh<_i23.AccountService>(),
        gh<_i22.UserService>(),
        gh<_i19.AppVersionService>(),
      ));
  gh.factory<_i32.SignupCubit>(() => _i32.SignupCubit(
        gh<_i23.AccountService>(),
        gh<_i18.ValidatorService>(),
      ));
  return getIt;
}
