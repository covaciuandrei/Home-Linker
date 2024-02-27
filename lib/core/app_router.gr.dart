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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../presentation/pages/introductive/introductive_page.dart' as _i1;
import '../presentation/pages/login/login_page.dart' as _i2;
import '../presentation/pages/signup/signup_page.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    IntroductiveRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.IntroductivePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignupPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/introductive',
          fullMatch: true,
        ),
        _i4.RouteConfig(
          IntroductiveRoute.name,
          path: '/introductive',
        ),
        _i4.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i4.RouteConfig(
          SignupRoute.name,
          path: '/signup',
        ),
      ];
}

/// generated route for
/// [_i1.IntroductivePage]
class IntroductiveRoute extends _i4.PageRouteInfo<void> {
  const IntroductiveRoute()
      : super(
          IntroductiveRoute.name,
          path: '/introductive',
        );

  static const String name = 'IntroductiveRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i4.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup',
        );

  static const String name = 'SignupRoute';
}
