// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:homelinker/models/property.dart' as _i17;
import 'package:homelinker/presentation/pages/home/home_page.dart' as _i3;
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart'
    as _i4;
import 'package:homelinker/presentation/pages/login/login_page.dart' as _i5;
import 'package:homelinker/presentation/pages/new_property/new_property_page.dart'
    as _i6;
import 'package:homelinker/presentation/pages/profile/profile_page.dart' as _i7;
import 'package:homelinker/presentation/pages/property/property_page.dart'
    as _i8;
import 'package:homelinker/presentation/pages/reset_password/email_sent_successfully_page.dart'
    as _i1;
import 'package:homelinker/presentation/pages/reset_password/forgot_password_page.dart'
    as _i2;
import 'package:homelinker/presentation/pages/reset_password/reset_password_page.dart'
    as _i9;
import 'package:homelinker/presentation/pages/reset_password/reset_password_successfully_page.dart'
    as _i10;
import 'package:homelinker/presentation/pages/settings/settings_page.dart'
    as _i11;
import 'package:homelinker/presentation/pages/signup/signup_page.dart' as _i13;
import 'package:homelinker/presentation/pages/signup/signup_successfully_page.dart'
    as _i12;
import 'package:homelinker/presentation/pages/splash/splash_page.dart' as _i14;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    EmailSentSuccessfullyRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EmailSentSuccessfullyPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    IntroductiveRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.IntroductivePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    NewPropertyRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NewPropertyPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
    PropertyRoute.name: (routeData) {
      final args = routeData.argsAs<PropertyRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.PropertyPage(
          key: args.key,
          property: args.property,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ResetPasswordPage(),
      );
    },
    ResetPasswordSuccessfullyRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ResetPasswordSuccessfullyPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SettingsPage(),
      );
    },
    SignUpSuccessfullyRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SignUpSuccessfullyPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SignupPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.EmailSentSuccessfullyPage]
class EmailSentSuccessfullyRoute extends _i15.PageRouteInfo<void> {
  const EmailSentSuccessfullyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EmailSentSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailSentSuccessfullyRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ForgotPasswordPage]
class ForgotPasswordRoute extends _i15.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.IntroductivePage]
class IntroductiveRoute extends _i15.PageRouteInfo<void> {
  const IntroductiveRoute({List<_i15.PageRouteInfo>? children})
      : super(
          IntroductiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroductiveRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NewPropertyPage]
class NewPropertyRoute extends _i15.PageRouteInfo<void> {
  const NewPropertyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NewPropertyRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPropertyRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PropertyPage]
class PropertyRoute extends _i15.PageRouteInfo<PropertyRouteArgs> {
  PropertyRoute({
    _i16.Key? key,
    required _i17.Property property,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          PropertyRoute.name,
          args: PropertyRouteArgs(
            key: key,
            property: property,
          ),
          initialChildren: children,
        );

  static const String name = 'PropertyRoute';

  static const _i15.PageInfo<PropertyRouteArgs> page =
      _i15.PageInfo<PropertyRouteArgs>(name);
}

class PropertyRouteArgs {
  const PropertyRouteArgs({
    this.key,
    required this.property,
  });

  final _i16.Key? key;

  final _i17.Property property;

  @override
  String toString() {
    return 'PropertyRouteArgs{key: $key, property: $property}';
  }
}

/// generated route for
/// [_i9.ResetPasswordPage]
class ResetPasswordRoute extends _i15.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ResetPasswordSuccessfullyPage]
class ResetPasswordSuccessfullyRoute extends _i15.PageRouteInfo<void> {
  const ResetPasswordSuccessfullyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ResetPasswordSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordSuccessfullyRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SignUpSuccessfullyPage]
class SignUpSuccessfullyRoute extends _i15.PageRouteInfo<void> {
  const SignUpSuccessfullyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignUpSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSuccessfullyRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SignupPage]
class SignupRoute extends _i15.PageRouteInfo<void> {
  const SignupRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
