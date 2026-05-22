import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/listing/listing_cubit.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/presentation/widgets/back_arrow_button.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class ListingPage extends StatelessWidget implements AutoRouteWrapper {
  const ListingPage({
    super.key,
    required this.listing,
    required this.user,
  });

  final Listing listing;
  final User user;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ListingCubit>(
      create: (_) => getIt<ListingCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListingCubit, BaseState>(
      listener: (context, state) {
        if (state is ListingDeletedState) {
          BlocProvider.of<HomeCubit>(context).refresh();
          AutoRouter.of(context).popForced();
        }
      },
      builder: (context, state) {
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            backgroundColor: Colors.lightBlue,
            extendBody: true,
            body: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.file(
                    listing.image,
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
                                              listing.property.propertyType.name
                                                  .translate(context, listing.property.propertyType.name)
                                                  .capitalize(),
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
                                                color: Color.fromRGBO(20, 112, 161, 1),
                                              ),
                                              Text(
                                                listing.property.location,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(20, 112, 161, 1),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context).listedBy} ${listing.property.ownerName}',
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
                                      property: listing.property,
                                      textSize: 26,
                                    ),
                                  ],
                                ),
                              ),
                              PropertySellingPointLine(
                                property: listing.property,
                                icons: const [
                                  Icons.calendar_month_outlined,
                                  Icons.real_estate_agent_outlined,
                                  Icons.landscape_outlined
                                ],
                                isFirstLine: true,
                              ),
                              PropertySellingPointLine(
                                property: listing.property,
                                icons: const [
                                  Icons.bathroom_outlined,
                                  Icons.bed_outlined,
                                  Icons.local_parking_outlined,
                                ],
                                isFirstLine: false,
                              ),
                              PropertyDescription(
                                description: listing.property.description,
                              ),
                              const SizedBox(height: 16),
                              if (listing.property.ownerEmail == user.email)
                                MainButton(
                                  color: const Color.fromARGB(255, 141, 12, 3),
                                  textColor: Colors.white,
                                  width: 200,
                                  text: AppLocalizations.of(context).deleteListing,
                                  onPressed: () {
                                    BlocProvider.of<ListingCubit>(context).deleteListing(property: listing.property);
                                  },
                                ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PropertyDescription extends StatelessWidget {
  const PropertyDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  AppLocalizations.of(context).description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(28, 83, 119, 1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(20, 112, 161, 1),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

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
                ? '${AppLocalizations.of(context).year} ${property.constructionYear}'
                : '${property.bathrooms} ${property.bathrooms == 1 ? AppLocalizations.of(context).bathroom : AppLocalizations.of(context).bathrooms}',
          ),
          PropertySellingPoint(
            icon: icons[1],
            text: isFirstLine
                ? '${AppLocalizations.of(context).perntru} ${property.listingType.name}'
                : '${property.bedrooms} ${property.bedrooms == 1 ? AppLocalizations.of(context).bedroom : AppLocalizations.of(context).bedrooms}',
          ),
          PropertySellingPoint(
            icon: icons[2],
            text: isFirstLine
                ? '${AppLocalizations.of(context).size} ${property.areaSize} ${AppLocalizations.of(context).squareMeters}'
                : '${property.parkingSpaces} ${property.parkingSpaces == 1 ? AppLocalizations.of(context).parkingSpace : AppLocalizations.of(context).parkingSpace}',
          ),
        ],
      ),
    );
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
                decoration:
                    const BoxDecoration(color: Color(0xFFBFDCEF), borderRadius: BorderRadius.all(Radius.circular(30))),
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
