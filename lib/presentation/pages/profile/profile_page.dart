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
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/profile_photo_editor.dart';

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
            backgroundColor: AppColors.primary,
            appBar: MainAppBar(title: AppLocalizations.of(context).profile),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.backgroundGradient,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 62,
                      ),
                      child: Column(
                        children: [
                          // ── Avatar ─────────────────────────────────
                          ProfilePhotoEditor(
                            image: _profilePicture,
                            onDarkBackground: true,
                            avatarSize: 132,
                            onChangePicture: () async {
                              await BlocProvider.of<ProfileCubit>(context).changePicture();
                            },
                            onDeletePicture: () async {
                              await BlocProvider.of<ProfileCubit>(context).deletePicture();
                            },
                          ),

                          const SizedBox(height: 36),

                          // ── Info Card ──────────────────────────────
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Column(
                              children: [
                                _InfoRow(
                                  icon: Icons.person_outline_rounded,
                                  label: AppLocalizations.of(context).name,
                                  value: _fullName,
                                ),
                                _buildDivider(),
                                _InfoRow(
                                  icon: Icons.email_outlined,
                                  label: AppLocalizations.of(context).email,
                                  value: _email,
                                ),
                                _buildDivider(),
                                _InfoRow(
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Divider ────────────────────────────────────────────────────────
Widget _buildDivider() {
  return Divider(
    height: 1,
    indent: 60,
    endIndent: 16,
    color: Colors.white.withValues(alpha: 0.12),
  );
}

// ── Info Row ───────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          const SizedBox(width: 14),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
