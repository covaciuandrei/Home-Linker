import 'package:auto_route/auto_route.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/services/account/account_service.dart';

/// Redirects unauthenticated users to the login screen before navigating to
/// any route this guard is attached to. Uses the secure-storage-backed login
/// token check rather than `FirebaseAuth.currentUser` so it survives cold
/// starts (the token is restored before this guard ever runs).
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isLoggedIn = await getIt<AccountService>().isUserLoggedIn();
    if (isLoggedIn) {
      resolver.next();
    } else {
      await router.replaceAll([const LoginRoute()]);
    }
  }
}
