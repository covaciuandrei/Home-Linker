import 'package:auto_route/auto_route.dart';
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart';
import 'package:homelinker/presentation/pages/login/login_page.dart';
import 'package:homelinker/presentation/pages/home/home_page.dart';
import 'package:homelinker/presentation/pages/reset_password/forgot_password_page.dart';
import 'package:homelinker/presentation/pages/reset_password/reset_password_page.dart';
import 'package:homelinker/presentation/pages/reset_password/reset_password_successfully_page.dart';
import 'package:homelinker/presentation/pages/signup/signup_page.dart';
import 'package:homelinker/presentation/pages/signup/signup_successfully_page.dart';
import 'package:injectable/injectable.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/introductive', page: IntroductivePage, initial: true),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/signup', page: SignupPage),
    AutoRoute(path: '/signup_successfully', page: SignUpSuccessfullyPage),
    AutoRoute(path: '/forgot_password', page: ForgotPasswordPage),
    AutoRoute(path: '/reset_password', page: ResetPasswordPage),
    AutoRoute(path: '/reset_pass_done', page: ResetPasswordSuccessfullyPage),
    AutoRoute(path: '/home_page', page: HomePage),
  ],
)
@singleton
class $AppRouter {}
