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
import '../cubit/introductive/introductive_cubit.dart' as _i8;
import '../cubit/listing/listing_cubit.dart' as _i28;
import '../cubit/login/login_cubit.dart' as _i29;
import '../cubit/new_property/new_property_cubit.dart' as _i30;
import '../cubit/profile/profile_cubit.dart' as _i31;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i26;
import '../cubit/reset_password/reset_password_cubit.dart' as _i12;
import '../cubit/settings/settings_cubit.dart' as _i32;
import '../cubit/signup/signup_cubit.dart' as _i33;
import '../cubit/splash/splash_cubit.dart' as _i14;
import '../data/database/database_provider.dart' as _i5;
import '../data/mappers/app_version_mapper.dart' as _i3;
import '../data/mappers/image_mapper.dart' as _i6;
import '../data/mappers/property_mapper.dart' as _i9;
import '../data/mappers/user_mapper.dart' as _i16;
import '../data/remote/app_version/app_version_source.dart' as _i4;
import '../data/remote/image/image_source.dart' as _i7;
import '../data/remote/property/property_source.dart' as _i11;
import '../data/remote/storage/storage_source.dart' as _i15;
import '../data/remote/user/user_source.dart' as _i18;
import '../data/repository/property_repository.dart' as _i10;
import '../data/repository/user_repository.dart' as _i17;
import '../data/secure_storage/secure_storage_source.dart' as _i13;
import '../services/account/account_service.dart' as _i24;
import '../services/app_version/app_version_service.dart' as _i20;
import '../services/file/file_service.dart' as _i25;
import '../services/image/image_service.dart' as _i21;
import '../services/property/property_service.dart' as _i22;
import '../services/user/user_service.dart' as _i23;
import '../services/validator_service.dart' as _i19;

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
  gh.factory<_i10.PropertyRepository>(() => _i10.PropertyRepository(
        gh<_i9.PropertyMapper>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i11.PropertySource>(
      () => _i11.PropertySource(gh<_i9.PropertyMapper>()));
  gh.factory<_i12.ResetPasswordCubit>(() => _i12.ResetPasswordCubit());
  gh.factory<_i13.SecureStorageSource>(() => _i13.SecureStorageSource());
  gh.factory<_i14.SplashCubit>(() => _i14.SplashCubit());
  gh.factory<_i15.StorageSource>(() => _i15.StorageSource());
  gh.factory<_i16.UserMapper>(() => _i16.UserMapper());
  gh.factory<_i17.UserRepository>(() => _i17.UserRepository(
        gh<_i16.UserMapper>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i18.UserSource>(() => _i18.UserSource(gh<_i16.UserMapper>()));
  gh.factory<_i19.ValidatorService>(() => _i19.ValidatorService());
  gh.factory<_i20.AppVersionService>(
      () => _i20.AppVersionService(gh<_i4.AppVersionSource>()));
  gh.factory<_i21.ImageService>(() => _i21.ImageService(
        gh<_i7.ImagesSource>(),
        gh<_i15.StorageSource>(),
      ));
  gh.factory<_i22.PropertyService>(() => _i22.PropertyService(
        gh<_i11.PropertySource>(),
        gh<_i10.PropertyRepository>(),
      ));
  gh.factory<_i23.UserService>(() => _i23.UserService(
        gh<_i18.UserSource>(),
        gh<_i13.SecureStorageSource>(),
        gh<_i17.UserRepository>(),
      ));
  gh.factory<_i24.AccountService>(() => _i24.AccountService(
        gh<_i13.SecureStorageSource>(),
        gh<_i23.UserService>(),
        gh<_i18.UserSource>(),
      ));
  gh.factory<_i25.FileService>(() => _i25.FileService(
        gh<_i15.StorageSource>(),
        gh<_i23.UserService>(),
        gh<_i7.ImagesSource>(),
      ));
  gh.factory<_i26.ForgotPasswordCubit>(
      () => _i26.ForgotPasswordCubit(gh<_i24.AccountService>()));
  gh.factory<_i27.HomeCubit>(() => _i27.HomeCubit(
        gh<_i22.PropertyService>(),
        gh<_i21.ImageService>(),
      ));
  gh.factory<_i28.ListingCubit>(() => _i28.ListingCubit(
        gh<_i22.PropertyService>(),
        gh<_i21.ImageService>(),
      ));
  gh.factory<_i29.LoginCubit>(() => _i29.LoginCubit(
        gh<_i24.AccountService>(),
        gh<_i19.ValidatorService>(),
        gh<_i23.UserService>(),
      ));
  gh.factory<_i30.NewPropertyCubit>(() => _i30.NewPropertyCubit(
        gh<_i22.PropertyService>(),
        gh<_i23.UserService>(),
        gh<_i25.FileService>(),
      ));
  gh.factory<_i31.ProfileCubit>(() => _i31.ProfileCubit(
        gh<_i25.FileService>(),
        gh<_i23.UserService>(),
        gh<_i21.ImageService>(),
        gh<_i20.AppVersionService>(),
      ));
  gh.factory<_i32.SettingsCubit>(() => _i32.SettingsCubit(
        gh<_i24.AccountService>(),
        gh<_i23.UserService>(),
        gh<_i20.AppVersionService>(),
      ));
  gh.factory<_i33.SignupCubit>(() => _i33.SignupCubit(
        gh<_i24.AccountService>(),
        gh<_i19.ValidatorService>(),
      ));
  return getIt;
}
