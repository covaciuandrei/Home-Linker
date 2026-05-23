import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.hasBackButtonOrDrawer = true,
    this.onBackButtonPressed,
    this.actions,
  });

  final String? title;
  final bool hasBackButtonOrDrawer;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.appBarGradient,
        boxShadow: [
          BoxShadow(
            color: Color(0x200D47A1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: hasBackButtonOrDrawer,
        title: Text(
          title ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
