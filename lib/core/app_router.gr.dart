// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:homelinker/models/property.dart' as _i12;
import 'package:homelinker/presentation/pages/home/home_page.dart' as _i2;
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart'
    as _i3;
import 'package:homelinker/presentation/pages/login/login_page.dart' as _i4;
import 'package:homelinker/presentation/pages/property/property_page.dart'
    as _i5;
import 'package:homelinker/presentation/pages/reset_password/forgot_password_page.dart'
    as _i1;
import 'package:homelinker/presentation/pages/reset_password/reset_password_page.dart'
    as _i6;
import 'package:homelinker/presentation/pages/reset_password/reset_password_successfully_page.dart'
    as _i7;
import 'package:homelinker/presentation/pages/signup/signup_page.dart' as _i9;
import 'package:homelinker/presentation/pages/signup/signup_successfully_page.dart'
    as _i8;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    ForgotPasswordRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    IntroductiveRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.IntroductivePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    PropertyRoute.name: (routeData) {
      final args = routeData.argsAs<PropertyRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PropertyPage(
          key: args.key,
          property: args.property,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ResetPasswordPage(),
      );
    },
    ResetPasswordSuccessfullyRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ResetPasswordSuccessfullyPage(),
      );
    },
    SignUpSuccessfullyRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SignUpSuccessfullyPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SignupPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i10.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.IntroductivePage]
class IntroductiveRoute extends _i10.PageRouteInfo<void> {
  const IntroductiveRoute({List<_i10.PageRouteInfo>? children})
      : super(
          IntroductiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroductiveRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PropertyPage]
class PropertyRoute extends _i10.PageRouteInfo<PropertyRouteArgs> {
  PropertyRoute({
    _i11.Key? key,
    required _i12.Property property,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PropertyRoute.name,
          args: PropertyRouteArgs(
            key: key,
            property: property,
          ),
          initialChildren: children,
        );

  static const String name = 'PropertyRoute';

  static const _i10.PageInfo<PropertyRouteArgs> page =
      _i10.PageInfo<PropertyRouteArgs>(name);
}

class PropertyRouteArgs {
  const PropertyRouteArgs({
    this.key,
    required this.property,
  });

  final _i11.Key? key;

  final _i12.Property property;

  @override
  String toString() {
    return 'PropertyRouteArgs{key: $key, property: $property}';
  }
}

/// generated route for
/// [_i6.ResetPasswordPage]
class ResetPasswordRoute extends _i10.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ResetPasswordSuccessfullyPage]
class ResetPasswordSuccessfullyRoute extends _i10.PageRouteInfo<void> {
  const ResetPasswordSuccessfullyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ResetPasswordSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordSuccessfullyRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignUpSuccessfullyPage]
class SignUpSuccessfullyRoute extends _i10.PageRouteInfo<void> {
  const SignUpSuccessfullyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SignUpSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSuccessfullyRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SignupPage]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
