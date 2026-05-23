import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/splash/splash_cubit.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => getIt<SplashCubit>(),
      child: this,
    );
  }
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    BlocProvider.of<SplashCubit>(context).load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, BaseState>(
      listener: (context, state) {
        if (state is NoUserFoundState) {
          AutoRouter.of(context).pushAndPopUntil(
            const IntroductiveRoute(),
            predicate: (route) => false,
          );
        } else if (state is UserLoggedInState) {
          AutoRouter.of(context).pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.splashGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Opacity(
                        opacity: _animation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.7),
                              Colors.white.withValues(alpha: 0.8),
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white,
                            ],
                          ).createShader(bounds);
                        },
                        child: const SvgIcon(
                          iconName: 'home',
                          color: Colors.white,
                          size: 200,
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.7),
                              Colors.white.withValues(alpha: 0.8),
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white,
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          AppLocalizations.of(context).appTitle,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
