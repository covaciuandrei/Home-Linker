import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.textController,
    required this.placeholder,
    this.isPassword = false,
  });

  final TextEditingController textController;
  final String placeholder;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 1, color: Colors.white, style: BorderStyle.solid)),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 5, 10),
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
