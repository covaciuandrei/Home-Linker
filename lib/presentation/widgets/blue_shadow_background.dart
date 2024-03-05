import 'package:flutter/material.dart';

class BlueShadowBackground extends StatelessWidget {
  const BlueShadowBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Opacity(
          opacity: 0.15,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.58,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(200, 80),
                topRight: Radius.elliptical(200, 80),
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        Opacity(
          opacity: 0.35,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(200, 80),
                topRight: Radius.elliptical(200, 80),
              ),
              color: Colors.lightBlue,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.52,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(200, 80),
              topRight: Radius.elliptical(200, 80),
            ),
            color: Colors.lightBlue,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: child,
        ),
      ],
    );
  }
}
