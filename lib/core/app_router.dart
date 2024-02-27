import 'package:auto_route/auto_route.dart';
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart';
import 'package:homelinker/presentation/pages/login/login_page.dart';
import 'package:homelinker/presentation/pages/signup/signup_page.dart';
import 'package:injectable/injectable.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/introductive', page: IntroductivePage, initial: true),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/signup', page: SignupPage),
  ],
)
@singleton
class $AppRouter {}
