import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';

@RoutePage()
class EmailSentSuccessfullyPage extends StatelessWidget {
  const EmailSentSuccessfullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlueShadowBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Success icon badge ───────────────────────
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.mark_email_read_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 32),

                // ── Title ────────────────────────────────────
                Text(
                  AppLocalizations.of(context).emailSentSuccessfully,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                ),
                const SizedBox(height: 16),

                // ── Subtitle ─────────────────────────────────
                Text(
                  AppLocalizations.of(context).emailNeededForValidatingAccount,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 40),

                // ── Action ───────────────────────────────────
                MainButton(
                  width: 200,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  text: AppLocalizations.of(context).done,
                  icon: Icons.check_rounded,
                  onPressed: () {
                    AutoRouter.of(context).pushAndPopUntil(
                      const IntroductiveRoute(),
                      predicate: (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
