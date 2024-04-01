import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.color = const Color.fromRGBO(70, 179, 231, 1),
    this.hasBackButton = true,
    this.onBackButtonPressed,
  });

  final String? title;
  final Color color;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      backgroundColor: color,
      leading: hasBackButton
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (onBackButtonPressed != null) {
                      onBackButtonPressed!();
                    }
                    AutoRouter.of(context).pop();
                  },
                );
              },
            )
          : const Text(''),
      title: Row(
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
