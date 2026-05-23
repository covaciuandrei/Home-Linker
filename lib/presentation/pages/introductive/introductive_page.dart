import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/introductive/introductive_cubit.dart';
import 'package:homelinker/presentation/widgets/introductive_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class IntroductivePage extends StatefulWidget implements AutoRouteWrapper {
  const IntroductivePage({super.key});

  @override
  State<IntroductivePage> createState() => _IntroductivePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<IntroductiveCubit>(
      create: (context) => getIt<IntroductiveCubit>(),
      child: this,
    );
  }
}

class _IntroductivePageState extends State<IntroductivePage> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    _animController.forward();
    BlocProvider.of<IntroductiveCubit>(context).load();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroductiveCubit, BaseState>(
      listener: (context, state) {
        if (state is NavigateToSignupState) {
          AutoRouter.of(context).push(const SignupRoute());
        } else if (state is NavigateToLoginState) {
          AutoRouter.of(context).push(const LoginRoute());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: IntroductiveBackground(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Welcome Text ─────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80, left: 32, right: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).welcome,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '${AppLocalizations.of(context).to} ',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: AppLocalizations.of(context).appTitle,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Home Icon ────────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.primaryGradient.createShader(bounds);
                      },
                      child: const SvgIcon(
                        iconName: 'home',
                        color: Colors.white,
                        size: 180,
                      ),
                    ),
                  ),

                  // ── CTA Buttons ──────────────────────────────
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Column(
                          children: [
                            // Primary CTA — Login
                            MainButton(
                              text: AppLocalizations.of(context).login,
                              width: 260,
                              height: 50,
                              isGradient: true,
                              onPressed: () => BlocProvider.of<IntroductiveCubit>(context).goToLogin(),
                            ),
                            const SizedBox(height: 14),
                            // Secondary CTA — Sign Up
                            MainButton(
                              text: AppLocalizations.of(context).signup,
                              width: 260,
                              height: 50,
                              isOutlined: true,
                              color: AppColors.primary,
                              onPressed: () => BlocProvider.of<IntroductiveCubit>(context).goToSignup(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
