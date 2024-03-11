import 'package:flutter/material.dart';

class PropertySellingPoint extends StatelessWidget {
  const PropertySellingPoint({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFE3EDF4),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xFFBFDCEF),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Icon(
                  icon,
                  // size: 40,
                  color: const Color.fromRGBO(20, 112, 161, 1),
                ),
              ),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color.fromRGBO(28, 83, 119, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
