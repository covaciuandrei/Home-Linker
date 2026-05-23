import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class LoginPage extends StatefulWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => getIt<LoginCubit>(),
      child: this,
    );
  }
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isButtonAvailable = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LoginCubit>(context).loadPage();
      _animController.forward();
    });

    emailTextController
        .addListener(() => BlocProvider.of<LoginCubit>(context).checkEmailValidity(emailTextController.text));
    passwordTextController
        .addListener(() => BlocProvider.of<LoginCubit>(context).checkPasswordValidity(passwordTextController.text));
  }

  @override
  void dispose() {
    _animController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, BaseState>(
      listener: (context, state) {
        if (state is NavigateToSignupState) {
          AutoRouter.of(context).replace(const SignupRoute());
        } else if (state is NavigateToIntroductiveState) {
          AutoRouter.of(context).replace(const SignupRoute());
        } else if (state is LoggedInSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        } else if (state is SomethingWentWrongState) {
          AutoRouter.of(context).popForced();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(AppLocalizations.of(context).somethingWrong)),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RightInputState) {
          isButtonAvailable = true;
        } else if (state is InputsErrorState) {
          isButtonAvailable = false;
        }

        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: BlueShadowBackground(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                      // ── Logo ─────────────────────────────────
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.8),
                                    Colors.white,
                                  ],
                                ).createShader(bounds);
                              },
                              child: const SvgIcon(
                                iconName: 'home',
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context).appTitle,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      // ── Form ─────────────────────────────────
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                MainTextField(
                                  textController: emailTextController,
                                  placeholder: AppLocalizations.of(context).email,
                                  prefixIcon: Icons.email_outlined,
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: passwordTextController,
                                  placeholder: AppLocalizations.of(context).password,
                                  isPassword: true,
                                  prefixIcon: Icons.lock_outline_rounded,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: MainTextButton(
                                    text: AppLocalizations.of(context).forgotPassword,
                                    onPressed: () => AutoRouter.of(context).push(
                                      const ForgotPasswordRoute(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                MainButton(
                                  width: 200,
                                  isGradient: false,
                                  color: Colors.white,
                                  textColor: AppColors.primary,
                                  text: AppLocalizations.of(context).login,
                                  isEnabled: isButtonAvailable,
                                  onPressed: () => BlocProvider.of<LoginCubit>(context).login(
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                      // ── Bottom Link ──────────────────────────
                      MainTextButton(
                        text: AppLocalizations.of(context).createNewAccount,
                        onPressed: () => BlocProvider.of<LoginCubit>(context).goToSignup(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
