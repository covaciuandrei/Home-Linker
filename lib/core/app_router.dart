import 'package:auto_route/auto_route.dart';
import 'package:homelinker/core/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = <AutoRoute>[
    AutoRoute(
        path: '/introductive', page: IntroductiveRoute.page, initial: true),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/signup', page: SignupRoute.page),
    AutoRoute(path: '/signup_successfully', page: SignUpSuccessfullyRoute.page),
    AutoRoute(path: '/forgot_password', page: ForgotPasswordRoute.page),
    AutoRoute(path: '/reset_password', page: ResetPasswordRoute.page),
    AutoRoute(
        path: '/reset_pass_done', page: ResetPasswordSuccessfullyRoute.page),
    AutoRoute(path: '/home_page', page: HomeRoute.page),
    AutoRoute(path: '/property', page: PropertyRoute.page),
    AutoRoute(path: '/profile', page: ProfileRoute.page),
  ];
}
