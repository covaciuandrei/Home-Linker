import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/reset_password/reset_password_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget implements AutoRouteWrapper {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => getIt<ResetPasswordCubit>(),
      child: this,
    );
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final oldPasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final repeatNewPasswordTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ResetPasswordCubit>(context).loadPage();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordTextController.dispose();
    newPasswordTextController.dispose();
    repeatNewPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                          child: const Icon(
                            Icons.password_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ── Form Fields ───────────────────────
                        MainTextField(
                          textController: oldPasswordTextController,
                          placeholder: AppLocalizations.of(context).oldPassword,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        const SizedBox(height: 16),
                        MainTextField(
                          textController: newPasswordTextController,
                          placeholder: AppLocalizations.of(context).newPassword,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        const SizedBox(height: 16),
                        MainTextField(
                          textController: repeatNewPasswordTextController,
                          placeholder: AppLocalizations.of(context).repeatNewPassword,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        const SizedBox(height: 36),

                        // ── Reset Button ──────────────────────
                        MainButton(
                          width: 200,
                          color: Colors.white,
                          textColor: AppColors.primary,
                          icon: Icons.refresh_rounded,
                          text: AppLocalizations.of(context).reset,
                          onPressed: () {
                            AutoRouter.of(context).pushAndPopUntil(
                              const ResetPasswordSuccessfullyRoute(),
                              predicate: (route) => false,
                            );
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
