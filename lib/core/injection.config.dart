// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../cubit/home/home_cubit.dart' as _i23;
import '../cubit/introductive/introductive_cubit.dart' as _i5;
import '../cubit/listing/listing_cubit.dart' as _i24;
import '../cubit/login/login_cubit.dart' as _i25;
import '../cubit/new_property/new_property_cubit.dart' as _i26;
import '../cubit/profile/profile_cubit.dart' as _i6;
import '../cubit/property/property_cubit.dart' as _i7;
import '../cubit/reset_password/forgot_password_cubit.dart' as _i22;
import '../cubit/reset_password/reset_password_cubit.dart' as _i10;
import '../cubit/settings/settings_cubit.dart' as _i27;
import '../cubit/signup/signup_cubit.dart' as _i28;
import '../cubit/splash/splash_cubit.dart' as _i12;
import '../data/mappers/image_mapper.dart' as _i3;
import '../data/mappers/property_mapper.dart' as _i8;
import '../data/mappers/user_mapper.dart' as _i14;
import '../data/remote/image/image_source.dart' as _i4;
import '../data/remote/property/property_source.dart' as _i9;
import '../data/remote/storage/storage_source.dart' as _i13;
import '../data/remote/user/user_source.dart' as _i15;
import '../data/secure_storage/secure_storage_source.dart' as _i11;
import '../services/account/account_service.dart' as _i20;
import '../services/file/file_service.dart' as _i21;
import '../services/image/image_service.dart' as _i17;
import '../services/property/property_service.dart' as _i18;
import '../services/user/user_service.dart' as _i19;
import '../services/validator_service.dart' as _i16;

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
  gh.factory<_i4.ImagesSource>(() => _i4.ImagesSource(gh<_i3.ImageMapper>()));
  gh.factory<_i5.IntroductiveCubit>(() => _i5.IntroductiveCubit());
  gh.factory<_i6.ProfileCubit>(() => _i6.ProfileCubit());
  gh.factory<_i7.PropertyCubit>(() => _i7.PropertyCubit());
  gh.factory<_i8.PropertyMapper>(() => _i8.PropertyMapper());
  gh.factory<_i9.PropertySource>(
      () => _i9.PropertySource(gh<_i8.PropertyMapper>()));
  gh.factory<_i10.ResetPasswordCubit>(() => _i10.ResetPasswordCubit());
  gh.factory<_i11.SecureStorageSource>(() => _i11.SecureStorageSource());
  gh.factory<_i12.SplashCubit>(() => _i12.SplashCubit());
  gh.factory<_i13.StorageSource>(() => _i13.StorageSource());
  gh.factory<_i14.UserMapper>(() => _i14.UserMapper());
  gh.factory<_i15.UserSource>(() => _i15.UserSource(gh<_i14.UserMapper>()));
  gh.factory<_i16.ValidatorService>(() => _i16.ValidatorService());
  gh.factory<_i17.ImageService>(() => _i17.ImageService(
        gh<_i4.ImagesSource>(),
        gh<_i13.StorageSource>(),
      ));
  gh.factory<_i18.PropertyService>(
      () => _i18.PropertyService(gh<_i9.PropertySource>()));
  gh.factory<_i19.UserService>(() => _i19.UserService(
        gh<_i15.UserSource>(),
        gh<_i11.SecureStorageSource>(),
      ));
  gh.factory<_i20.AccountService>(() => _i20.AccountService(
        gh<_i11.SecureStorageSource>(),
        gh<_i19.UserService>(),
      ));
  gh.factory<_i21.FileService>(() => _i21.FileService(
        gh<_i13.StorageSource>(),
        gh<_i19.UserService>(),
        gh<_i4.ImagesSource>(),
      ));
  gh.factory<_i22.ForgotPasswordCubit>(
      () => _i22.ForgotPasswordCubit(gh<_i20.AccountService>()));
  gh.factory<_i23.HomeCubit>(() => _i23.HomeCubit(
        gh<_i18.PropertyService>(),
        gh<_i17.ImageService>(),
      ));
  gh.factory<_i24.ListingCubit>(() => _i24.ListingCubit(
        gh<_i18.PropertyService>(),
        gh<_i17.ImageService>(),
      ));
  gh.factory<_i25.LoginCubit>(() => _i25.LoginCubit(
        gh<_i20.AccountService>(),
        gh<_i16.ValidatorService>(),
      ));
  gh.factory<_i26.NewPropertyCubit>(() => _i26.NewPropertyCubit(
        gh<_i18.PropertyService>(),
        gh<_i19.UserService>(),
        gh<_i21.FileService>(),
      ));
  gh.factory<_i27.SettingsCubit>(
      () => _i27.SettingsCubit(gh<_i20.AccountService>()));
  gh.factory<_i28.SignupCubit>(() => _i28.SignupCubit(
        gh<_i20.AccountService>(),
        gh<_i16.ValidatorService>(),
      ));
  return getIt;
}
