import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onGetCurrentLocationPressed,
    required this.onPickLocationPressed,
  });

  final VoidCallback onGetCurrentLocationPressed;
  final VoidCallback onPickLocationPressed;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
      ],
    );
  }
}
