import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/models/property.dart';

class ListingPrice extends StatelessWidget {
  const ListingPrice({
    super.key,
    required this.property,
    required this.textSize,
  });

  final Property property;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '\$',
        style: TextStyle(
          fontSize: textSize,
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
        children: <TextSpan>[
          TextSpan(
            text: formatPrice(property.price),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: textSize,
            ),
          ),
          TextSpan(
            text: property.listingType == ListingType.rent ? '/mo' : '',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: textSize * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

String formatPrice(double price) {
  if (price >= 1000) {
    double formattedPrice = price / 1000.0;
    return '${formattedPrice.toStringAsFixed(formattedPrice.truncateToDouble() == formattedPrice ? 0 : 1)}k';
  } else {
    return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
  }
}
