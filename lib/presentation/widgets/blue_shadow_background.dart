import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';

class BlueShadowBackground extends StatelessWidget {
  const BlueShadowBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: child,
    );
  }
}
