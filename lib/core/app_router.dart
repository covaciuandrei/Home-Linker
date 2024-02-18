import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart';
import 'package:homelinker/presentation/pages/login/login_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/introductive', page: IntroductivePage, initial: true),
    AutoRoute(path: '/login', page: LoginPage),
  ],
)
@singleton
class $AppRouter {}
