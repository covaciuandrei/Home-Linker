import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.color = const Color.fromRGBO(70, 179, 231, 1),
    this.hasBackButtonOrDrawer = true,
    this.onBackButtonPressed,
  });

  final String? title;
  final Color color;
  final bool hasBackButtonOrDrawer;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      backgroundColor: color,
      automaticallyImplyLeading: hasBackButtonOrDrawer,
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
