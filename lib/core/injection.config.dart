// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i28;
import '../cubit/introductive/introductive_cubit.dart' as _i9;
import '../cubit/listing/listing_cubit.dart' as _i29;
import '../cubit/login/login_cubit.dart' as _i30;
import '../cubit/new_property/new_property_cubit.dart' as _i31;
import '../cubit/profile/profile_cubit.dart' as _i32;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i27;
import '../cubit/reset_password/reset_password_cubit.dart' as _i13;
import '../cubit/settings/settings_cubit.dart' as _i33;
import '../cubit/signup/signup_cubit.dart' as _i34;
import '../cubit/splash/splash_cubit.dart' as _i15;
import '../data/database/database_provider.dart' as _i5;
import '../data/mappers/app_version_mapper.dart' as _i3;
import '../data/mappers/image_mapper.dart' as _i6;
import '../data/mappers/property_mapper.dart' as _i10;
import '../data/mappers/user_mapper.dart' as _i17;
import '../data/remote/app_version/app_version_source.dart' as _i4;
import '../data/remote/image/image_source.dart' as _i8;
import '../data/remote/property/property_source.dart' as _i12;
import '../data/remote/storage/storage_source.dart' as _i16;
import '../data/remote/user/user_source.dart' as _i19;
import '../data/repository/image_repository.dart' as _i7;
import '../data/repository/property_repository.dart' as _i11;
import '../data/repository/user_repository.dart' as _i18;
import '../data/secure_storage/secure_storage_source.dart' as _i14;
import '../services/account/account_service.dart' as _i25;
import '../services/app_version/app_version_service.dart' as _i21;
import '../services/file/file_service.dart' as _i26;
import '../services/image/image_service.dart' as _i22;
import '../services/property/property_service.dart' as _i23;
import '../services/user/user_service.dart' as _i24;
import '../services/validator_service.dart' as _i20;

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
  gh.factory<_i4.AppVersionSource>(() => _i4.AppVersionSource(gh<_i3.AppVersionMapper>()));
  gh.singleton<_i5.DatabaseProvider>(() => _i5.DatabaseProvider());
  gh.factory<_i6.ImageMapper>(() => _i6.ImageMapper());
  gh.factory<_i7.ImageRepository>(() => _i7.ImageRepository(gh<_i5.DatabaseProvider>()));
  gh.factory<_i8.ImagesSource>(() => _i8.ImagesSource(gh<_i6.ImageMapper>()));
  gh.factory<_i9.IntroductiveCubit>(() => _i9.IntroductiveCubit());
  gh.factory<_i10.PropertyMapper>(() => _i10.PropertyMapper());
  gh.factory<_i11.PropertyRepository>(() => _i11.PropertyRepository(
        gh<_i10.PropertyMapper>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i12.PropertySource>(() => _i12.PropertySource(gh<_i10.PropertyMapper>()));
  gh.factory<_i13.ResetPasswordCubit>(() => _i13.ResetPasswordCubit());
  gh.factory<_i14.SecureStorageSource>(() => _i14.SecureStorageSource());
  gh.factory<_i15.SplashCubit>(() => _i15.SplashCubit());
  gh.factory<_i16.StorageSource>(() => _i16.StorageSource());
  gh.factory<_i17.UserMapper>(() => _i17.UserMapper());
  gh.factory<_i18.UserRepository>(() => _i18.UserRepository(
        gh<_i17.UserMapper>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i19.UserSource>(() => _i19.UserSource(gh<_i17.UserMapper>()));
  gh.factory<_i20.ValidatorService>(() => _i20.ValidatorService());
  gh.factory<_i21.AppVersionService>(() => _i21.AppVersionService(gh<_i4.AppVersionSource>()));
  gh.factory<_i22.ImageService>(() => _i22.ImageService(
        gh<_i8.ImagesSource>(),
        gh<_i16.StorageSource>(),
        gh<_i7.ImageRepository>(),
      ));
  gh.factory<_i23.PropertyService>(() => _i23.PropertyService(
        gh<_i12.PropertySource>(),
        gh<_i11.PropertyRepository>(),
      ));
  gh.factory<_i24.UserService>(() => _i24.UserService(
        gh<_i19.UserSource>(),
        gh<_i14.SecureStorageSource>(),
        gh<_i18.UserRepository>(),
      ));
  gh.factory<_i25.AccountService>(() => _i25.AccountService(
        gh<_i14.SecureStorageSource>(),
        gh<_i24.UserService>(),
        gh<_i19.UserSource>(),
        gh<_i5.DatabaseProvider>(),
      ));
  gh.factory<_i26.FileService>(() => _i26.FileService(
        gh<_i16.StorageSource>(),
        gh<_i24.UserService>(),
        gh<_i8.ImagesSource>(),
      ));
  gh.factory<_i27.ForgotPasswordCubit>(() => _i27.ForgotPasswordCubit(gh<_i25.AccountService>()));
  gh.factory<_i28.HomeCubit>(() => _i28.HomeCubit(
        gh<_i23.PropertyService>(),
        gh<_i22.ImageService>(),
      ));
  gh.factory<_i29.ListingCubit>(() => _i29.ListingCubit(
        gh<_i23.PropertyService>(),
        gh<_i22.ImageService>(),
      ));
  gh.factory<_i30.LoginCubit>(() => _i30.LoginCubit(
        gh<_i25.AccountService>(),
        gh<_i20.ValidatorService>(),
        gh<_i24.UserService>(),
      ));
  gh.factory<_i31.NewPropertyCubit>(() => _i31.NewPropertyCubit(
        gh<_i23.PropertyService>(),
        gh<_i24.UserService>(),
        gh<_i26.FileService>(),
      ));
  gh.factory<_i32.ProfileCubit>(() => _i32.ProfileCubit(
        gh<_i26.FileService>(),
        gh<_i24.UserService>(),
        gh<_i22.ImageService>(),
        gh<_i21.AppVersionService>(),
      ));
  gh.factory<_i33.SettingsCubit>(() => _i33.SettingsCubit(
        gh<_i25.AccountService>(),
        gh<_i24.UserService>(),
        gh<_i21.AppVersionService>(),
      ));
  gh.factory<_i34.SignupCubit>(() => _i34.SignupCubit(
        gh<_i25.AccountService>(),
        gh<_i20.ValidatorService>(),
      ));
  return getIt;
}
