import 'package:flutter/material.dart';
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
        text: formatPrice(property.price),
        style: TextStyle(
          fontSize: textSize,
          color: const Color.fromRGBO(28, 83, 119, 1),
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '\$',
            style: TextStyle(
              color: const Color.fromRGBO(28, 83, 119, 1),
              fontWeight: FontWeight.bold,
              fontSize: textSize,
            ),
          ),
          TextSpan(
            text: property.listingType == ListingType.rent ? '/month' : '',
            style: TextStyle(
              color: const Color.fromRGBO(28, 83, 119, 1),
              fontWeight: FontWeight.bold,
              fontSize: textSize * 0.7,
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
