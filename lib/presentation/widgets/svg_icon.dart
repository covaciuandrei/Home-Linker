import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String iconName;
  final double size;
  final Color? color;

  const SvgIcon({
    required this.iconName,
    this.color,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/assets/images/$iconName.svg',
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      height: size,
    );
  }
}
