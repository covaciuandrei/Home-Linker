import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/profile/profile_cubit.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class ProfilePage extends StatefulWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt<ProfileCubit>(),
      child: this,
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profilePicture;
  String _email = '';
  String _phoneNumber = '';
  String _fullName = '';
  AppVersion? _appVersion;

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<ProfileCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfilePageLoadedState) {
          _profilePicture = state.profilePicture;
          _email = state.user.email;
          _phoneNumber = state.user.phone;
          _fullName = state.user.name;
          _appVersion = state.appVersion;
        } else if (state is ImageUploadedSuccessfullyState) {
          _profilePicture = state.image;
        } else if (state is ImageDeletedSuccessfullyState) {
          _profilePicture = null;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            appBar: MainAppBar(title: AppLocalizations.of(context).profile),
            body: BlueShadowBackground(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // ── Avatar ─────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: _profilePicture == null
                          ? const SvgIcon(iconName: 'avatar', size: 140)
                          : CircularImage(imageFile: _profilePicture!),
                    ),
                    const SizedBox(height: 12),

                    // ── Photo Actions ──────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ActionChip(
                          icon: Icons.edit_rounded,
                          label: AppLocalizations.of(context).uploadPhoto,
                          onTap: () async {
                            await BlocProvider.of<ProfileCubit>(context).changePicture();
                          },
                        ),
                        const SizedBox(width: 8),
                        _ActionChip(
                          icon: Icons.delete_outline_rounded,
                          label: AppLocalizations.of(context).deleteListing.split(' ').first,
                          isDestructive: true,
                          enabled: _profilePicture != null,
                          onTap: _profilePicture == null
                              ? null
                              : () async {
                                  await BlocProvider.of<ProfileCubit>(context).deletePicture();
                                },
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    // ── Info Cards ─────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          _InfoCard(
                            icon: Icons.person_outline_rounded,
                            label: AppLocalizations.of(context).name,
                            value: _fullName,
                          ),
                          const SizedBox(height: 12),
                          _InfoCard(
                            icon: Icons.email_outlined,
                            label: AppLocalizations.of(context).email,
                            value: _email,
                          ),
                          const SizedBox(height: 12),
                          _InfoCard(
                            icon: Icons.phone_outlined,
                            label: AppLocalizations.of(context).phoneNumber,
                            value: _phoneNumber,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Version ────────────────────────────────
                    Text(
                      _appVersion != null
                          ? '${AppLocalizations.of(context).version} ${_appVersion!.appVersion} @ ${_appVersion!.releaseDate.year}'
                          : '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Action Chip ────────────────────────────────────────────────────
class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.enabled = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final color = !enabled
        ? Colors.white.withValues(alpha: 0.3)
        : isDestructive
            ? AppColors.error
            : Colors.white;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Info Card ──────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Circular Image ─────────────────────────────────────────────────
class CircularImage extends StatelessWidget {
  final File imageFile;

  const CircularImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.file(
          imageFile,
          height: 140,
          width: 140,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
