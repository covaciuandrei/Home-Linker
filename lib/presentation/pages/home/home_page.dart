import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/models/filters.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/utils/extension_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSaved = false;

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Property> properties = [];

    return BlocConsumer<HomeCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DataLoadedState) {
          properties = state.properties;
        }
        return GestureDetector(
          onTap: () => BlocProvider.of<HomeCubit>(context).resetFilter(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: const Text(
                'Home Linker',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterItem(
                          filterType: FilterType.house,
                          icon: Icons.home,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.house),
                        ),
                        FilterItem(
                          filterType: FilterType.apartment,
                          icon: Icons.apartment_rounded,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.apartment),
                        ),
                        FilterItem(
                          filterType: FilterType.rent,
                          icon: Icons.home_work,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.rent),
                        ),
                        FilterItem(
                          filterType: FilterType.sale,
                          icon: Icons.local_offer,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.sale),
                        ),
                        FilterItem(
                          filterType: FilterType.price,
                          icon: Icons.attach_money_rounded,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.price),
                        ),
                        FilterItem(
                          filterType: FilterType.location,
                          icon: Icons.location_on,
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .filter(filterType: FilterType.location),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        child: SizedBox(
                          height: 170,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(250, 250, 250, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 0.5),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      properties[index].imageLink,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 6),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: formatPrice(
                                                            properties[index]
                                                                .price),
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.lightBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                            text: '\$',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          TextSpan(
                                                            text: properties[
                                                                            index]
                                                                        .listingType ==
                                                                    ListingType
                                                                        .rent
                                                                ? '/month'
                                                                : '',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${properties[index].propertyType.name.capitalize()} ${properties[index].areaSize} m²',
                                                      style: const TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.lightBlue,
                                                    size: 20,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      properties[index]
                                                          .location,
                                                      style: const TextStyle(
                                                        color: Colors.lightBlue,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: properties[index]
                                                                  .listingType ==
                                                              ListingType.sale
                                                          ? Colors.lightGreen
                                                          : const Color
                                                              .fromARGB(255,
                                                              132, 101, 216),
                                                      size: 12,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4,
                                                          horizontal: 8),
                                                      child: Text(
                                                        'For ${properties[index].listingType.name.capitalize()}',
                                                        style: const TextStyle(
                                                          color:
                                                              Colors.lightBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _isSaved = !_isSaved;
                                                });
                                              },
                                              child: _isSaved
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color: Colors.lightBlue,
                                                      size: 30,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.lightBlue,
                                                      size: 30,
                                                    ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.icon,
    required this.filterType,
    required this.onPressed,
  });

  final IconData icon;
  final FilterType filterType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 90,
          width: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              Text(
                filterType.name.capitalize(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
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
