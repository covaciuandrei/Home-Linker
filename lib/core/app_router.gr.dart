import 'package:google_maps_flutter/google_maps_flutter.dart';
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:homelinker/models/listing.dart' as _i21;
import 'package:homelinker/models/place_location.dart' as _i9;
import 'package:homelinker/models/user.dart' as _i22;
import 'package:homelinker/presentation/pages/favorites/favorites_page.dart'
    as _i2;
import 'package:homelinker/presentation/pages/home/home_page.dart' as _i4;
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart'
    as _i5;
import 'package:homelinker/presentation/pages/listing/listing_page.dart' as _i6;
import 'package:homelinker/presentation/pages/login/login_page.dart' as _i7;
import 'package:homelinker/presentation/pages/map_page.dart' as _i8;
import 'package:homelinker/presentation/pages/new_property/new_property_page.dart'
    as _i10;
import 'package:homelinker/presentation/pages/profile/profile_page.dart'
    as _i11;
import 'package:homelinker/presentation/pages/reset_password/email_sent_successfully_page.dart'
    as _i1;
import 'package:homelinker/presentation/pages/reset_password/forgot_password_page.dart'
    as _i3;
import 'package:homelinker/presentation/pages/reset_password/reset_password_page.dart'
    as _i12;
import 'package:homelinker/presentation/pages/reset_password/reset_password_successfully_page.dart'
    as _i13;
import 'package:homelinker/presentation/pages/settings/settings_page.dart'
    as _i14;
import 'package:homelinker/presentation/pages/signup/signup_page.dart' as _i16;
import 'package:homelinker/presentation/pages/signup/signup_second_page.dart'
    as _i17;
import 'package:homelinker/presentation/pages/signup/signup_successfully_page.dart'
    as _i15;
import 'package:homelinker/presentation/pages/splash/splash_page.dart' as _i18;

abstract class $AppRouter extends _i19.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    EmailSentSuccessfullyRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EmailSentSuccessfullyPage(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i2.FavoritesPage()),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i3.ForgotPasswordPage()),
      );
    },
    HomeRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i4.HomePage()),
      );
    },
    IntroductiveRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i5.IntroductivePage()),
      );
    },
    ListingRoute.name: (routeData) {
      final args = routeData.argsAs<ListingRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i6.ListingPage(
          key: args.key,
          listing: args.listing,
          user: args.user,
        )),
      );
    },
    LoginRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i7.LoginPage()),
      );
    },
    MapRoute.name: (routeData) {
      final args =
          routeData.argsAs<MapRouteArgs>(orElse: () => const MapRouteArgs());
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.MapPage(
          key: args.key,
          location: args.location,
          isSelecting: args.isSelecting,
        ),
      );
    },
    NewPropertyRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i10.NewPropertyPage()),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i11.ProfilePage()),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i12.ResetPasswordPage()),
      );
    },
    ResetPasswordSuccessfullyRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ResetPasswordSuccessfullyPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i14.SettingsPage()),
      );
    },
    SignUpSuccessfullyRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SignUpSuccessfullyPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i16.SignupPage()),
      );
    },
    SignupSecondRoute.name: (routeData) {
      final args = routeData.argsAs<SignupSecondRouteArgs>();
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(
            child: _i17.SignupSecondPage(
          key: args.key,
          email: args.email,
          password: args.password,
        )),
      );
    },
    SplashRoute.name: (routeData) {
      return _i19.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.WrappedRoute(child: const _i18.SplashPage()),
      );
    },
  };
}

/// generated route for
/// [_i1.EmailSentSuccessfullyPage]
class EmailSentSuccessfullyRoute extends _i19.PageRouteInfo<void> {
  const EmailSentSuccessfullyRoute({List<_i19.PageRouteInfo>? children})
      : super(
          EmailSentSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailSentSuccessfullyRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FavoritesPage]
class FavoritesRoute extends _i19.PageRouteInfo<void> {
  const FavoritesRoute({List<_i19.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i19.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i5.IntroductivePage]
class IntroductiveRoute extends _i19.PageRouteInfo<void> {
  const IntroductiveRoute({List<_i19.PageRouteInfo>? children})
      : super(
          IntroductiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroductiveRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ListingPage]
class ListingRoute extends _i19.PageRouteInfo<ListingRouteArgs> {
  ListingRoute({
    _i20.Key? key,
    required _i21.Listing listing,
    required _i22.User user,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ListingRoute.name,
          args: ListingRouteArgs(
            key: key,
            listing: listing,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ListingRoute';

  static const _i19.PageInfo<ListingRouteArgs> page =
      _i19.PageInfo<ListingRouteArgs>(name);
}

class ListingRouteArgs {
  const ListingRouteArgs({
    this.key,
    required this.listing,
    required this.user,
  });

  final _i20.Key? key;

  final _i21.Listing listing;

  final _i22.User user;

  @override
  String toString() {
    return 'ListingRouteArgs{key: $key, listing: $listing, user: $user}';
  }
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute({List<_i19.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MapPage]
class MapRoute extends _i19.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    _i20.Key? key,
    _i9.PlaceLocation location =
        const _i9.PlaceLocation(latLng: LatLng(44.43, 26), address: ''),
    bool isSelecting = true,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            location: location,
            isSelecting: isSelecting,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const _i19.PageInfo<MapRouteArgs> page =
      _i19.PageInfo<MapRouteArgs>(name);
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    this.location =
        const _i9.PlaceLocation(latLng: LatLng(44.43, 26), address: ''),
    this.isSelecting = true,
  });

  final _i20.Key? key;

  final _i9.PlaceLocation location;

  final bool isSelecting;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, location: $location, isSelecting: $isSelecting}';
  }
}

/// generated route for
/// [_i10.NewPropertyPage]
class NewPropertyRoute extends _i19.PageRouteInfo<void> {
  const NewPropertyRoute({List<_i19.PageRouteInfo>? children})
      : super(
          NewPropertyRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPropertyRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ProfilePage]
class ProfileRoute extends _i19.PageRouteInfo<void> {
  const ProfileRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ResetPasswordPage]
class ResetPasswordRoute extends _i19.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ResetPasswordSuccessfullyPage]
class ResetPasswordSuccessfullyRoute extends _i19.PageRouteInfo<void> {
  const ResetPasswordSuccessfullyRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ResetPasswordSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordSuccessfullyRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SettingsPage]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SignUpSuccessfullyPage]
class SignUpSuccessfullyRoute extends _i19.PageRouteInfo<void> {
  const SignUpSuccessfullyRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SignUpSuccessfullyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSuccessfullyRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i16.SignupPage]
class SignupRoute extends _i19.PageRouteInfo<void> {
  const SignupRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SignupSecondPage]
class SignupSecondRoute extends _i19.PageRouteInfo<SignupSecondRouteArgs> {
  SignupSecondRoute({
    _i20.Key? key,
    required String email,
    required String password,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          SignupSecondRoute.name,
          args: SignupSecondRouteArgs(
            key: key,
            email: email,
            password: password,
          ),
          initialChildren: children,
        );

  static const String name = 'SignupSecondRoute';

  static const _i19.PageInfo<SignupSecondRouteArgs> page =
      _i19.PageInfo<SignupSecondRouteArgs>(name);
}

class SignupSecondRouteArgs {
  const SignupSecondRouteArgs({
    this.key,
    required this.email,
    required this.password,
  });

  final _i20.Key? key;

  final String email;

  final String password;

  @override
  String toString() {
    return 'SignupSecondRouteArgs{key: $key, email: $email, password: $password}';
  }
}

/// generated route for
/// [_i18.SplashPage]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i19.PageInfo<void> page = _i19.PageInfo<void>(name);
}
