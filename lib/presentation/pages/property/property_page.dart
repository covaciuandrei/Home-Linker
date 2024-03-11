import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/presentation/widgets/back_arrow_button.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/property_sellling_point.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class PropertyPage extends StatelessWidget {
  const PropertyPage({
    Key? key,
    required this.property,
  }) : super(key: key);

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      extendBody: true,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              property.imageLink,
              fit: BoxFit.cover,
            ),
          ),
          const BackArrowButton(),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        property.propertyType.name.capitalize(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(28, 83, 119, 1),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 20,
                                          color:
                                              Color.fromRGBO(20, 112, 161, 1),
                                        ),
                                        Text(
                                          property.location,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(20, 112, 161, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Listed by ${property.ownerName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(20, 112, 161, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListingPrice(
                                property: property,
                                textSize: 26,
                              ),
                            ],
                          ),
                        ),
                        PropertySellingPointLine(
                            property: property,
                            isFirstLine: true,
                            icons: const [
                              Icons.calendar_month_outlined,
                              Icons.real_estate_agent_outlined,
                              Icons.landscape_outlined
                            ]),
                        PropertySellingPointLine(
                          property: property,
                          icons: const [
                            Icons.bathroom_outlined,
                            Icons.bed_outlined,
                            Icons.local_parking_outlined,
                          ],
                          isFirstLine: false,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          child: const Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(28, 83, 119, 1),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '   Charming apartment nestled in a vibrant neighborhood, offering modern comforts and convenience. This cozy space features a spacious bedroom, a well-equipped kitchen, and a stylish living area with ample natural light. ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(20, 112, 161, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '   Charming apartment nestled in a vibrant neighborhood, offering modern comforts and convenience. This cozy space features a spacious bedroom, a well-equipped kitchen, and a stylish living area with ample natural light. ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(20, 112, 161, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '   Charming apartment nestled in a vibrant neighborhood, offering modern comforts and convenience. This cozy space features a spacious bedroom, a well-equipped kitchen, and a stylish living area with ample natural light. ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(20, 112, 161, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
