import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/reset_password/forgot_password_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget implements AutoRouteWrapper {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: this,
    );
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailTextController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ForgotPasswordCubit>(context).loadPage();
    emailTextController.addListener(() {
      BlocProvider.of<ForgotPasswordCubit>(context).checkEmailValidity(emailTextController.text);
    });
  }

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, BaseState>(
      listener: (context, state) {
        if (state is EmailSentSuccessfullyState) {
          AutoRouter.of(context).push(const EmailSentSuccessfullyRoute());
        } else if (state is InvalidEmailState) {
          _showError(context, AppLocalizations.of(context).invalidEmail);
        } else if (state is SomethingWentWrongState) {
          _showError(context, AppLocalizations.of(context).somethingWrong);
        }
      },
      builder: (context, state) {
        if (state is RightInputState) {
          _isButtonEnabled = true;
        } else if (state is InputsErrorState) {
          _isButtonEnabled = false;
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Icon ───────────────────────────────
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_reset_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── Instructions ───────────────────────
                        Text(
                          AppLocalizations.of(context).emailNeededForValidatingAccount,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.5,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),

                        // ── Email Field ───────────────────────
                        MainTextField(
                          textController: emailTextController,
                          placeholder: AppLocalizations.of(context).email,
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 32),

                        // ── Send Button ───────────────────────
                        MainButton(
                          width: 200,
                          color: Colors.white,
                          textColor: AppColors.primary,
                          text: AppLocalizations.of(context).send,
                          icon: Icons.send_rounded,
                          isEnabled: _isButtonEnabled,
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .resetPassword(email: emailTextController.text);
                          },
                        ),
                      ],
                    ),
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
