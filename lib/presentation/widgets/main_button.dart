import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';

class MainButton extends StatefulWidget {
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
    this.isGradient = false,
    this.isOutlined = false,
    this.isDestructive = false,
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
  final bool isGradient;
  final bool isOutlined;
  final bool isDestructive;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine colors
    Color bgColor;
    Color fgColor;

    if (widget.isDestructive) {
      bgColor = AppColors.error;
      fgColor = Colors.white;
    } else if (widget.isOutlined) {
      bgColor = Colors.transparent;
      fgColor = widget.color ?? AppColors.primary;
    } else {
      bgColor = widget.color ?? AppColors.primary;
      fgColor = widget.textColor ?? Colors.white;
    }

    if (!widget.isEnabled) {
      bgColor = AppColors.textTertiary.withValues(alpha: 0.3);
      fgColor = AppColors.textTertiary;
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 48,
      child: GestureDetector(
        onTapDown: widget.isEnabled ? (_) => _controller.forward() : null,
        onTapUp: widget.isEnabled
            ? (_) {
                _controller.reverse();
                widget.onPressed();
              }
            : null,
        onTapCancel: widget.isEnabled ? () => _controller.reverse() : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.isGradient && widget.isEnabled && !widget.isOutlined
                  ? AppColors.primaryGradient
                  : null,
              color: !widget.isGradient || !widget.isEnabled ? bgColor : null,
              borderRadius: BorderRadius.circular(28),
              border: widget.isOutlined
                  ? Border.all(color: fgColor, width: 1.5)
                  : null,
              boxShadow: widget.isEnabled && !widget.isOutlined
                  ? [
                      BoxShadow(
                        color: (widget.isDestructive ? AppColors.error : AppColors.primary)
                            .withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 20,
                      color: widget.iconColor ?? fgColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.text,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: fgColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
