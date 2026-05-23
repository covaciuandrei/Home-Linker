import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/settings/settings_cubit.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SettingsPage extends StatefulWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => getIt<SettingsCubit>(),
      child: this,
    );
  }
}

class _SettingsPageState extends State<SettingsPage> {
  AppVersion? _appVersion;

  @override
  void initState() {
    BlocProvider.of<SettingsCubit>(context).loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<SettingsCubit, BaseState>(
      listener: (context, state) {
        if (state is LoggedOutSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const IntroductiveRoute(),
            predicate: (route) => false,
          );
        } else if (state is AccountDeletedSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const IntroductiveRoute(),
            predicate: (route) => false,
          );
        } else if (state is SomethingWentWrongState) {
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
        if (state is SettingsPageLoadedState) {
          _appVersion = state.appVersion;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            backgroundColor: AppColors.surface,
            appBar: MainAppBar(title: AppLocalizations.of(context).settings),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                children: [
                  // ── Avatar ─────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const SvgIcon(iconName: 'avatar', size: 100),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ── Settings Options Card ─────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Column(
                      children: [
                        _SettingsRow(
                          icon: Icons.privacy_tip_rounded,
                          iconColor: AppColors.primary,
                          text: AppLocalizations.of(context).privacyPolicy,
                          onPressed: () {},
                        ),
                        Divider(
                          height: 1,
                          indent: 60,
                          endIndent: 20,
                          color: AppColors.divider,
                        ),
                        _SettingsRow(
                          icon: Icons.library_books_rounded,
                          iconColor: AppColors.secondary,
                          text: AppLocalizations.of(context).termsAndCons,
                          onPressed: () {},
                        ),
                        Divider(
                          height: 1,
                          indent: 60,
                          endIndent: 20,
                          color: AppColors.divider,
                        ),
                        _SettingsRow(
                          icon: Icons.lock_reset_rounded,
                          iconColor: AppColors.warning,
                          text: AppLocalizations.of(context).resetPassword,
                          onPressed: () {
                            AutoRouter.of(context).push(const ResetPasswordRoute());
                          },
                        ),
                        Divider(
                          height: 1,
                          indent: 60,
                          endIndent: 20,
                          color: AppColors.divider,
                        ),
                        _SettingsRow(
                          icon: Icons.delete_forever_rounded,
                          iconColor: AppColors.error,
                          text: AppLocalizations.of(context).deleteAccount,
                          isDestructive: true,
                          onPressed: () => _showDeleteBottomSheet(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Logout Button ──────────────────────────
                  MainButton(
                    width: 240,
                    height: 50,
                    isOutlined: true,
                    color: AppColors.error,
                    textColor: AppColors.error,
                    icon: Icons.logout_rounded,
                    text: AppLocalizations.of(context).logout,
                    onPressed: () => BlocProvider.of<SettingsCubit>(context).logOut(),
                  ),

                  const SizedBox(height: 40),

                  // ── Version ────────────────────────────────
                  Text(
                    _appVersion != null
                        ? '${AppLocalizations.of(context).version} ${_appVersion!.appVersion} @ ${_appVersion!.releaseDate.year}'
                        : '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
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

// ── Delete Account Bottom Sheet ────────────────────────────────────
void _showDeleteBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (bottomSheetContext) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).deleteAccount,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    isOutlined: true,
                    text: AppLocalizations.of(context).cancel,
                    onPressed: () => Navigator.of(bottomSheetContext).pop(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MainButton(
                    isDestructive: true,
                    text: AppLocalizations.of(context).deleteAccount,
                    onPressed: () {
                      BlocProvider.of<SettingsCubit>(context).deleteAccount();
                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// ── Settings Row ───────────────────────────────────────────────────
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.onPressed,
    this.isDestructive = false,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textColor = isDestructive ? AppColors.error : AppColors.textPrimary;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
