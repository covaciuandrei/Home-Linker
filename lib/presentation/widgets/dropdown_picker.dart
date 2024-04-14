import 'package:flutter/material.dart';
import 'package:homelinker/utils/extension_methods.dart';

class DropdownPicker extends StatefulWidget {
  const DropdownPicker({
    super.key,
    required this.list,
    this.width = 140,
    this.onValueChanged,
  });
  final List<String> list;
  final double width;
  final void Function(String)? onValueChanged;

  @override
  State<DropdownPicker> createState() => _DropdownPickerState();
}

class _DropdownPickerState extends State<DropdownPicker> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: DropdownButton<String>(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colors.lightBlue,
          isDense: true,
          focusColor: Colors.purple,
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: 24,
          ),
          elevation: 16,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          underline: Container(height: 0),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
              widget.onValueChanged!(dropdownValue);
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.capitalize()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
