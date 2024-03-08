// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:homelinker/presentation/pages/home/home_page.dart' as _i2;
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart'
    as _i3;
import 'package:homelinker/presentation/pages/login/login_page.dart' as _i4;
import 'package:homelinker/presentation/pages/reset_password/forgot_password_page.dart'
    as _i1;
import 'package:homelinker/presentation/pages/reset_password/reset_password_page.dart'
    as _i5;
import 'package:homelinker/presentation/pages/reset_password/reset_password_successfully_page.dart'
    as _i6;
import 'package:homelinker/presentation/pages/signup/signup_page.dart' as _i8;
import 'package:homelinker/presentation/pages/signup/signup_successfully_page.dart'
    as _i7;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    ForgotPasswordRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    IntroductiveRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.IntroductivePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ResetPasswordPage(),
      );
    },
    ResetPasswordSuccessfullyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ResetPasswordSuccessfullyPage(),
      );
    },
    SignUpSuccessfullyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SignUpSuccessfullyPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SignupPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.IntroductivePage]
class IntroductiveRoute extends _i9.PageRouteInfo<void> {
  const IntroductiveRoute({List<_i9.PageRouteInfo>? children})
      : super(
          IntroductiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroductiveRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ResetPasswordPage]
class ResetPasswordRoute extends _i9.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ResetPasswordSuccessfullyPage]
class ResetPasswordSuccessfullyRoute extends _i9.PageRouteInfo<void> {
  const ResetPasswordSuccessfullyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ResetPasswordSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordSuccessfullyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignUpSuccessfullyPage]
class SignUpSuccessfullyRoute extends _i9.PageRouteInfo<void> {
  const SignUpSuccessfullyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSuccessfullyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignupPage]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
