import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.isEnabled = true,
    this.color,
    this.textColor,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? iconColor;
  final bool isEnabled;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: IgnorePointer(
        ignoring: !isEnabled,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              isEnabled ? (color ?? const Color.fromRGBO(250, 250, 250, 1)) : Colors.grey,
            ),
          ),
          onPressed: isEnabled ? onPressed : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    icon,
                    size: 24,
                    color: iconColor ?? Colors.lightBlue,
                  ),
                ),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
