import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/utils/extension_methods.dart';

class DropdownPicker extends StatefulWidget {
  const DropdownPicker({
    super.key,
    required this.list,
    this.width = double.infinity,
    this.onValueChanged,
    this.isDarkMode = true,
  });

  final List<String> list;
  final double width;
  final void Function(String)? onValueChanged;
  final bool isDarkMode;

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
    final isDark = widget.isDarkMode;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.4) : AppColors.divider;
    final bgColor = isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.surfaceVariant;

    return Container(
      width: widget.width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          isExpanded: true,
          borderRadius: BorderRadius.circular(14),
          dropdownColor: isDark ? AppColors.primaryLight : AppColors.cardBackground,
          focusColor: AppColors.secondary,
          value: dropdownValue,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark ? Colors.white.withValues(alpha: 0.8) : AppColors.textTertiary,
            size: 22,
          ),
          elevation: 4,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
              widget.onValueChanged?.call(dropdownValue);
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.capitalize(),
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
