import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homelinker/core/app_theme.dart';

class PriceRangeInputs extends StatefulWidget {
  const PriceRangeInputs({
    super.key,
    required this.initialMinimum,
    required this.initialMaximum,
    required this.minimumLabel,
    required this.maximumLabel,
    required this.onChanged,
    this.resetSignal = 0,
  });

  final String initialMinimum;
  final String initialMaximum;
  final String minimumLabel;
  final String maximumLabel;
  final ValueChanged<PriceRangeInputValue> onChanged;
  final int resetSignal;

  @override
  State<PriceRangeInputs> createState() => _PriceRangeInputsState();
}

class PriceRangeInputValue {
  const PriceRangeInputValue({
    required this.minimumText,
    required this.maximumText,
  });

  final String minimumText;
  final String maximumText;
}

class _PriceRangeInputsState extends State<PriceRangeInputs> {
  late final TextEditingController _minimumController;
  late final TextEditingController _maximumController;

  @override
  void initState() {
    super.initState();
    _minimumController = TextEditingController(text: widget.initialMinimum);
    _maximumController = TextEditingController(text: widget.initialMaximum);
    _minimumController.addListener(_notifyChanged);
    _maximumController.addListener(_notifyChanged);
  }

  @override
  void didUpdateWidget(covariant PriceRangeInputs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetSignal != widget.resetSignal) {
      _minimumController.text = widget.initialMinimum;
      _maximumController.text = widget.initialMaximum;
    }
  }

  @override
  void dispose() {
    _minimumController
      ..removeListener(_notifyChanged)
      ..dispose();
    _maximumController
      ..removeListener(_notifyChanged)
      ..dispose();
    super.dispose();
  }

  void _notifyChanged() {
    widget.onChanged(
      PriceRangeInputValue(
        minimumText: _minimumController.text,
        maximumText: _maximumController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PriceInput(
            controller: _minimumController,
            label: widget.minimumLabel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PriceInput(
            controller: _maximumController,
            label: widget.maximumLabel,
          ),
        ),
      ],
    );
  }
}

class _PriceInput extends StatelessWidget {
  const _PriceInput({
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
      decoration: InputDecoration(
        labelText: label,
        prefixText: r'$ ',
        prefixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }
}

String formatPriceInputValue(double value) => value.round().toString();

RangeValues normalizedPriceRange({
  required String minimumText,
  required String maximumText,
  required RangeValues bounds,
}) {
  final lowerBound = bounds.start <= bounds.end ? bounds.start : bounds.end;
  final upperBound = bounds.start <= bounds.end ? bounds.end : bounds.start;
  final minimum = _parsePrice(minimumText, lowerBound).clamp(lowerBound, upperBound).toDouble();
  final maximum = _parsePrice(maximumText, upperBound).clamp(lowerBound, upperBound).toDouble();

  if (minimum <= maximum) {
    return RangeValues(minimum, maximum);
  }
  return RangeValues(maximum, minimum);
}

double _parsePrice(String value, double fallback) {
  final normalized = value.trim();
  if (normalized.isEmpty) return fallback;
  return double.tryParse(normalized) ?? fallback;
}
