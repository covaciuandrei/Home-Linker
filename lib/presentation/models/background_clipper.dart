import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 1.75 * 220);
    path.quadraticBezierTo(size.width / 4, size.height - 1.75 * 160,
        size.width / 2, size.height - 1.75 * 175);
    path.quadraticBezierTo(3 / 4 * size.width, size.height - 1.75 * 190,
        size.width, size.height - 1.75 * 130);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
