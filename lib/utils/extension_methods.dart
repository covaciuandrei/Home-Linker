import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String translate(BuildContext context, String value) {
    switch (value) {
      case 'house':
        return AppLocalizations.of(context).house;
      case 'apartment':
        return AppLocalizations.of(context).apartment;
      case 'rent':
        return AppLocalizations.of(context).rent;
      case 'sale':
        return AppLocalizations.of(context).sale;
      case 'price':
        return AppLocalizations.of(context).price;
      case 'location':
        return AppLocalizations.of(context).location;
      default:
        return value;
    }
  }
}
