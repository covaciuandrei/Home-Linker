import 'package:auto_route/auto_route.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/auth_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  AppRouter() : _authGuard = AuthGuard();

  final AuthGuard _authGuard;

  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  late final List<AutoRoute> routes = <AutoRoute>[
    AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/introductive', page: IntroductiveRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/signup', page: SignupRoute.page),
    AutoRoute(path: '/signup_second', page: SignupSecondRoute.page),
    AutoRoute(path: '/signup_successfully', page: SignUpSuccessfullyRoute.page),
    AutoRoute(path: '/forgot_password', page: ForgotPasswordRoute.page),
    AutoRoute(path: '/reset_password', page: ResetPasswordRoute.page),
    AutoRoute(path: '/reset_pass_done', page: ResetPasswordSuccessfullyRoute.page),
    AutoRoute(path: '/home_page', page: HomeRoute.page, guards: [_authGuard]),
    AutoRoute(path: '/favorites', page: FavoritesRoute.page, guards: [_authGuard]),
    CupertinoRoute(path: '/listing', page: ListingRoute.page, guards: [_authGuard]),
    AutoRoute(path: '/profile', page: ProfileRoute.page, guards: [_authGuard]),
    AutoRoute(path: '/settings', page: SettingsRoute.page, guards: [_authGuard]),
    AutoRoute(path: '/new_property', page: NewPropertyRoute.page, guards: [_authGuard]),
    AutoRoute(path: '/mail_sent', page: EmailSentSuccessfullyRoute.page),
    AutoRoute(path: '/map_page', page: MapRoute.page, guards: [_authGuard]),
  ];
}
