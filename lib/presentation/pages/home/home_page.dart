import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/models/property.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSaved = false;
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
        return Scaffold(
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
          body: ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 6),
                                          child: Text(
                                            '${formatPrice(properties[index].price)} \$',
                                            style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${properties[index].type.name.capitalize()} ${properties[index].areaSize} m²',
                                              style: const TextStyle(
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.bold,
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
                                              properties[index].location,
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
                                                  : const Color.fromARGB(
                                                      255, 132, 101, 216),
                                              size: 12,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: Text(
                                                'For ${properties[index].listingType.name.capitalize()}',
                                                style: const TextStyle(
                                                  color: Colors.lightBlue,
                                                  fontWeight: FontWeight.bold,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSaved = !isSaved;
                                        });
                                      },
                                      child: isSaved
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.lightBlue,
                                              size: 30,
                                            )
                                          : const Icon(
                                              Icons.favorite_border_outlined,
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
        );
      },
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
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
