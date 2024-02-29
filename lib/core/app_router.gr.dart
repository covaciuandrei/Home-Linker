// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../presentation/pages/introductive/introductive_page.dart' as _i1;
import '../presentation/pages/login/login_page.dart' as _i2;
import '../presentation/pages/reset_password/forgot_password_page.dart' as _i5;
import '../presentation/pages/reset_password/reset_password_page.dart' as _i6;
import '../presentation/pages/reset_password/reset_password_successfully_page.dart'
    as _i7;
import '../presentation/pages/signup/signup_page.dart' as _i3;
import '../presentation/pages/signup/signup_successfully_page.dart' as _i4;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    IntroductiveRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.IntroductivePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignupPage(),
      );
    },
    SignUpSuccessfullyRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpSuccessfullyPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ForgotPasswordPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ResetPasswordPage(),
      );
    },
    ResetPasswordSuccessfullyRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ResetPasswordSuccessfullyPage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/introductive',
          fullMatch: true,
        ),
        _i8.RouteConfig(
          IntroductiveRoute.name,
          path: '/introductive',
        ),
        _i8.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i8.RouteConfig(
          SignupRoute.name,
          path: '/signup',
        ),
        _i8.RouteConfig(
          SignUpSuccessfullyRoute.name,
          path: '/signup_successfully',
        ),
        _i8.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot_password',
        ),
        _i8.RouteConfig(
          ResetPasswordRoute.name,
          path: '/reset_password',
        ),
        _i8.RouteConfig(
          ResetPasswordSuccessfullyRoute.name,
          path: '/reset_pass_done',
        ),
      ];
}

/// generated route for
/// [_i1.IntroductivePage]
class IntroductiveRoute extends _i8.PageRouteInfo<void> {
  const IntroductiveRoute()
      : super(
          IntroductiveRoute.name,
          path: '/introductive',
        );

  static const String name = 'IntroductiveRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i8.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i4.SignUpSuccessfullyPage]
class SignUpSuccessfullyRoute extends _i8.PageRouteInfo<void> {
  const SignUpSuccessfullyRoute()
      : super(
          SignUpSuccessfullyRoute.name,
          path: '/signup_successfully',
        );

  static const String name = 'SignUpSuccessfullyRoute';
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i8.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot_password',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i6.ResetPasswordPage]
class ResetPasswordRoute extends _i8.PageRouteInfo<void> {
  const ResetPasswordRoute()
      : super(
          ResetPasswordRoute.name,
          path: '/reset_password',
        );

  static const String name = 'ResetPasswordRoute';
}

/// generated route for
/// [_i7.ResetPasswordSuccessfullyPage]
class ResetPasswordSuccessfullyRoute extends _i8.PageRouteInfo<void> {
  const ResetPasswordSuccessfullyRoute()
      : super(
          ResetPasswordSuccessfullyRoute.name,
          path: '/reset_pass_done',
        );

  static const String name = 'ResetPasswordSuccessfullyRoute';
}
