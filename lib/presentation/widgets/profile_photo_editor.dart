import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

class ProfilePhotoEditor extends StatelessWidget {
  const ProfilePhotoEditor({
    super.key,
    required this.image,
    required this.onChangePicture,
    required this.onDeletePicture,
    this.onDarkBackground = false,
    this.avatarSize = 132,
    this.isBusy = false,
  });

  final File? image;
  final VoidCallback onChangePicture;
  final VoidCallback onDeletePicture;
  final bool onDarkBackground;
  final double avatarSize;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null;
    final localizations = AppLocalizations.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        AbsorbPointer(
          absorbing: isBusy,
          child: AnimatedOpacity(
            opacity: isBusy ? 0.55 : 1,
            duration: const Duration(milliseconds: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ProfileAvatar(
                  image: image,
                  avatarSize: avatarSize,
                  onDarkBackground: onDarkBackground,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 132,
                      child: _PhotoActionButton(
                        icon: hasImage ? Icons.edit_rounded : Icons.file_upload_outlined,
                        label: hasImage ? localizations.edit : localizations.upload,
                        onTap: onChangePicture,
                        onDarkBackground: onDarkBackground,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 132,
                      child: _PhotoActionButton(
                        icon: Icons.delete_outline_rounded,
                        label: localizations.delete,
                        onTap: hasImage ? onDeletePicture : null,
                        onDarkBackground: onDarkBackground,
                        isDestructive: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isBusy)
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.image,
    required this.avatarSize,
    required this.onDarkBackground,
  });

  final File? image;
  final double avatarSize;
  final bool onDarkBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: onDarkBackground ? null : AppColors.primaryGradient,
        border: onDarkBackground
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.32),
                width: 3,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: onDarkBackground ? 0.24 : 0.18),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: onDarkBackground ? Colors.white.withValues(alpha: 0.92) : Colors.white,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: image == null
              ? SvgIcon(iconName: 'avatar', size: avatarSize)
              : Image.file(
                  image!,
                  height: avatarSize,
                  width: avatarSize,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class _PhotoActionButton extends StatelessWidget {
  const _PhotoActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.onDarkBackground,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool onDarkBackground;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = _foregroundColor(enabled);
    final borderColor = _borderColor(enabled);
    final backgroundColor = _backgroundColor(enabled);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _foregroundColor(bool enabled) {
    if (!enabled) {
      return onDarkBackground ? Colors.white.withValues(alpha: 0.42) : AppColors.textTertiary;
    }
    if (onDarkBackground) {
      return Colors.white;
    }
    return isDestructive ? AppColors.error : AppColors.primary;
  }

  Color _borderColor(bool enabled) {
    if (!enabled) {
      return onDarkBackground ? Colors.white.withValues(alpha: 0.16) : AppColors.divider;
    }
    if (onDarkBackground) {
      return Colors.white.withValues(alpha: 0.28);
    }
    return (isDestructive ? AppColors.error : AppColors.primary).withValues(alpha: 0.22);
  }

  Color _backgroundColor(bool enabled) {
    if (!enabled) {
      return onDarkBackground ? Colors.white.withValues(alpha: 0.06) : AppColors.surfaceVariant;
    }
    if (onDarkBackground) {
      return Colors.white.withValues(alpha: 0.14);
    }
    return (isDestructive ? AppColors.error : AppColors.primary).withValues(alpha: 0.08);
  }
}
