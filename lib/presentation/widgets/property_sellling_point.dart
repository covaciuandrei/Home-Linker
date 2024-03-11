import 'package:flutter/material.dart';
import 'package:homelinker/models/property.dart';

class PropertySellingPointLine extends StatelessWidget {
  const PropertySellingPointLine({
    super.key,
    required this.property,
    required this.icons,
    required this.isFirstLine,
  });

  final Property property;
  final List<IconData> icons;
  final bool isFirstLine;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            PropertySellingPoint(
              icon: icons[0],
              text: isFirstLine
                  ? 'Year ${property.constructionYear}'
                  : '${property.bathrooms} ${property.bathrooms == 1 ? 'bathroom' : 'bathrooms'}',
            ),
            PropertySellingPoint(
              icon: icons[1],
              text: isFirstLine
                  ? 'For ${property.listingType.name}'
                  : '${property.bedrooms} ${property.bedrooms == 1 ? 'bedroom' : 'bedrooms'}',
            ),
            PropertySellingPoint(
              icon: icons[2],
              text: isFirstLine
                  ? 'Size ${property.areaSize} m²'
                  : '${property.parkingSpaces} ${property.parkingSpaces == 1 ? 'parking space' : 'parking spaces'}',
            ),
          ],
        ));
  }
}

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
