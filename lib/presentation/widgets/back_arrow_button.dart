import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.075,
          left: MediaQuery.of(context).size.width * 0.075,
        ),
        padding: const EdgeInsets.only(right: 2),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(255, 255, 255, 07),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color.fromRGBO(20, 112, 161, 1),
        ),
      ),
      onTap: () => AutoRouter.of(context).pop(),
    );
  }
}
