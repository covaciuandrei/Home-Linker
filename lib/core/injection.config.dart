// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../cubit/home/home_cubit.dart' as _i654;
import '../cubit/introductive/introductive_cubit.dart' as _i75;
import '../cubit/listing/listing_cubit.dart' as _i225;
import '../cubit/login/login_cubit.dart' as _i983;
import '../cubit/new_property/new_property_cubit.dart' as _i1070;
import '../cubit/profile/profile_cubit.dart' as _i289;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i110;
import '../cubit/reset_password/reset_password_cubit.dart' as _i980;
import '../cubit/settings/settings_cubit.dart' as _i411;
import '../cubit/signup/signup_cubit.dart' as _i767;
import '../cubit/splash/splash_cubit.dart' as _i963;
import '../data/database/database_provider.dart' as _i1014;
import '../data/mappers/app_version_mapper.dart' as _i7;
import '../data/mappers/image_mapper.dart' as _i1051;
import '../data/mappers/property_mapper.dart' as _i347;
import '../data/mappers/user_mapper.dart' as _i455;
import '../data/remote/app_version/app_version_source.dart' as _i956;
import '../data/remote/image/image_source.dart' as _i328;
import '../data/remote/property/property_source.dart' as _i910;
import '../data/remote/storage/storage_source.dart' as _i893;
import '../data/remote/user/user_source.dart' as _i905;
import '../data/repository/image_repository.dart' as _i20;
import '../data/repository/property_repository.dart' as _i646;
import '../data/repository/user_repository.dart' as _i361;
import '../data/secure_storage/secure_storage_source.dart' as _i863;
import '../services/account/account_service.dart' as _i1018;
import '../services/app_version/app_version_service.dart' as _i45;
import '../services/file/file_service.dart' as _i420;
import '../services/image/image_service.dart' as _i208;
import '../services/property/property_service.dart' as _i428;
import '../services/user/user_service.dart' as _i261;
import '../services/validator_service.dart' as _i488;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i75.IntroductiveCubit>(() => _i75.IntroductiveCubit());
  gh.factory<_i963.SplashCubit>(() => _i963.SplashCubit());
  gh.factory<_i980.ResetPasswordCubit>(() => _i980.ResetPasswordCubit());
  gh.factory<_i863.SecureStorageSource>(() => _i863.SecureStorageSource());
  gh.factory<_i1051.ImageMapper>(() => _i1051.ImageMapper());
  gh.factory<_i455.UserMapper>(() => _i455.UserMapper());
  gh.factory<_i7.AppVersionMapper>(() => _i7.AppVersionMapper());
  gh.factory<_i347.PropertyMapper>(() => _i347.PropertyMapper());
  gh.factory<_i893.StorageSource>(() => _i893.StorageSource());
  gh.factory<_i488.ValidatorService>(() => _i488.ValidatorService());
  gh.singleton<_i1014.DatabaseProvider>(() => _i1014.DatabaseProvider());
  gh.factory<_i20.ImageRepository>(
      () => _i20.ImageRepository(gh<_i1014.DatabaseProvider>()));
  gh.factory<_i646.PropertyRepository>(() => _i646.PropertyRepository(
        gh<_i347.PropertyMapper>(),
        gh<_i1014.DatabaseProvider>(),
      ));
  gh.factory<_i328.ImagesSource>(
      () => _i328.ImagesSource(gh<_i1051.ImageMapper>()));
  gh.factory<_i905.UserSource>(() => _i905.UserSource(gh<_i455.UserMapper>()));
  gh.factory<_i361.UserRepository>(() => _i361.UserRepository(
        gh<_i455.UserMapper>(),
        gh<_i1014.DatabaseProvider>(),
      ));
  gh.factory<_i910.PropertySource>(
      () => _i910.PropertySource(gh<_i347.PropertyMapper>()));
  gh.factory<_i208.ImageService>(() => _i208.ImageService(
        gh<_i328.ImagesSource>(),
        gh<_i893.StorageSource>(),
        gh<_i20.ImageRepository>(),
      ));
  gh.factory<_i956.AppVersionSource>(
      () => _i956.AppVersionSource(gh<_i7.AppVersionMapper>()));
  gh.factory<_i428.PropertyService>(() => _i428.PropertyService(
        gh<_i910.PropertySource>(),
        gh<_i646.PropertyRepository>(),
      ));
  gh.factory<_i261.UserService>(() => _i261.UserService(
        gh<_i905.UserSource>(),
        gh<_i863.SecureStorageSource>(),
        gh<_i361.UserRepository>(),
      ));
  gh.factory<_i654.HomeCubit>(() => _i654.HomeCubit(
        gh<_i428.PropertyService>(),
        gh<_i208.ImageService>(),
        gh<_i261.UserService>(),
        gh<_i1014.DatabaseProvider>(),
      ));
  gh.factory<_i225.ListingCubit>(() => _i225.ListingCubit(
        gh<_i428.PropertyService>(),
        gh<_i208.ImageService>(),
      ));
  gh.factory<_i420.FileService>(() => _i420.FileService(
        gh<_i893.StorageSource>(),
        gh<_i261.UserService>(),
        gh<_i328.ImagesSource>(),
      ));
  gh.factory<_i1018.AccountService>(() => _i1018.AccountService(
        gh<_i863.SecureStorageSource>(),
        gh<_i261.UserService>(),
        gh<_i905.UserSource>(),
        gh<_i1014.DatabaseProvider>(),
      ));
  gh.factory<_i45.AppVersionService>(
      () => _i45.AppVersionService(gh<_i956.AppVersionSource>()));
  gh.factory<_i289.ProfileCubit>(() => _i289.ProfileCubit(
        gh<_i420.FileService>(),
        gh<_i261.UserService>(),
        gh<_i208.ImageService>(),
        gh<_i45.AppVersionService>(),
      ));
  gh.factory<_i1070.NewPropertyCubit>(() => _i1070.NewPropertyCubit(
        gh<_i428.PropertyService>(),
        gh<_i261.UserService>(),
        gh<_i420.FileService>(),
      ));
  gh.factory<_i767.SignupCubit>(() => _i767.SignupCubit(
        gh<_i1018.AccountService>(),
        gh<_i488.ValidatorService>(),
      ));
  gh.factory<_i983.LoginCubit>(() => _i983.LoginCubit(
        gh<_i1018.AccountService>(),
        gh<_i488.ValidatorService>(),
        gh<_i261.UserService>(),
        gh<_i1014.DatabaseProvider>(),
      ));
  gh.factory<_i110.ForgotPasswordCubit>(
      () => _i110.ForgotPasswordCubit(gh<_i1018.AccountService>()));
  gh.factory<_i411.SettingsCubit>(() => _i411.SettingsCubit(
        gh<_i1018.AccountService>(),
        gh<_i261.UserService>(),
        gh<_i45.AppVersionService>(),
      ));
  return getIt;
}
