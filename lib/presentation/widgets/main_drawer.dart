import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/main.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.languages,
  });

  final List<String> languages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: AppColors.cardBackground,
      child: Column(
        children: [
          // ── Drawer Header ──────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              24,
              24 + MediaQuery.of(context).padding.top,
              24,
              20,
            ),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).appTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // ── Navigation Items ───────────────────────────
                  _DrawerItem(
                    icon: Icons.favorite_rounded,
                    label: AppLocalizations.of(context).favorites,
                    onTap: () {
                      Navigator.of(context).pop();
                      AutoRouter.of(context).push(const FavoritesRoute());
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.settings_rounded,
                    label: AppLocalizations.of(context).settings,
                    onTap: () {
                      Navigator.of(context).pop();
                      AutoRouter.of(context).push(const SettingsRoute());
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.person_rounded,
                    label: AppLocalizations.of(context).profile,
                    onTap: () {
                      Navigator.of(context).pop();
                      AutoRouter.of(context).push(const ProfileRoute());
                    },
                  ),

                  // ── Divider ────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: AppColors.divider),
                  ),

                  // ── Language Section Label ─────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Language',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  // ── Language List ──────────────────────────────
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: SizedBox(
                              width: 32,
                              height: 32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: getFlag(languages[index]),
                              ),
                            ),
                            title: Text(
                              getLanguage(languages[index]),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textTertiary,
                              size: 20,
                            ),
                            onTap: () {
                              MyApp.of(context).setLocale(
                                Locale.fromSubtags(languageCode: languages[index]),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textTertiary,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}

Widget getFlag(String countryCode) {
  switch (countryCode) {
    case 'ro':
      return CountryFlag.fromCountryCode('ro');
    case 'en':
      return CountryFlag.fromCountryCode('gb');
    default:
      return CountryFlag.fromCountryCode('');
  }
}

String getLanguage(String countryCode) {
  switch (countryCode) {
    case 'ro':
      return 'Română';
    case 'en':
      return 'English';
    default:
      return '';
  }
}
