import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/models/filters.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/range.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_drawer.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSaved = false;
  List<String> languages = [];
  bool _isPagePriceFiltered = false;
  double _minimumPrice = 0;
  double _maximumPrice = 0;
  RangeValues priceRange = const RangeValues(0, 100000);

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).load();
    super.initState();
  }

  Future<double> _showMinPricePickerDialog() async {
    final selectedPrice = await showDialog<double>(
      context: context,
      builder: (context) => PricePickerDialog(
        initialPrice: _minimumPrice,
        range: Range(min: priceRange.start, max: priceRange.end),
      ),
    );

    if (selectedPrice != null) {
      setState(() {
        _minimumPrice = selectedPrice;
      });
    }
    return selectedPrice ?? _minimumPrice;
  }

  Future<double> _showMaxPricePickerDialog() async {
    final selectedPrice = await showDialog<double>(
      context: context,
      builder: (context) => PricePickerDialog(
        initialPrice: _maximumPrice,
        range: Range(min: priceRange.start, max: priceRange.end),
      ),
    );

    if (selectedPrice != null) {
      setState(() {
        _maximumPrice = selectedPrice;
      });
    }
    return selectedPrice ?? _maximumPrice;
  }

  @override
  Widget build(BuildContext context) {
    List<Listing> listings = [];

    return BlocConsumer<HomeCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DataLoadedState) {
          listings = state.listings;
          languages = state.languages;
          priceRange = state.priceRange;
          _isPagePriceFiltered = state.isPageFiltered;
        }
        return GestureDetector(
          onTap: () => BlocProvider.of<HomeCubit>(context).resetFilter(),
          child: LoadingScreen(
            loading: state is PendingState,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                onPressed: () => AutoRouter.of(context).push(const NewPropertyRoute()),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              appBar: MainAppBar(title: AppLocalizations.of(context).appTitle),
              drawer: MainDrawer(languages: languages),
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
                            onPressed: () => BlocProvider.of<HomeCubit>(context).filter(filterType: FilterType.house),
                          ),
                          FilterItem(
                            filterType: FilterType.apartment,
                            icon: Icons.apartment_rounded,
                            onPressed: () =>
                                BlocProvider.of<HomeCubit>(context).filter(filterType: FilterType.apartment),
                          ),
                          FilterItem(
                            filterType: FilterType.rent,
                            icon: Icons.home_work,
                            onPressed: () => BlocProvider.of<HomeCubit>(context).filter(filterType: FilterType.rent),
                          ),
                          FilterItem(
                            filterType: FilterType.sale,
                            icon: Icons.local_offer,
                            onPressed: () => BlocProvider.of<HomeCubit>(context).filter(filterType: FilterType.sale),
                          ),
                          FilterItem(
                            filterType: FilterType.price,
                            icon: Icons.attach_money_rounded,
                            onPressed: () async {
                              await showDialog<double>(
                                context: context,
                                builder: (context) => StatefulBuilder(builder: (context, setState) {
                                  return Center(
                                    child: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Minimum price: $_minimumPrice'),
                                            MainButton(
                                              width: 200,
                                              color: Colors.lightBlue,
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                final minimumPrice = await _showMinPricePickerDialog();
                                                setState(
                                                  () {
                                                    _minimumPrice = minimumPrice;
                                                  },
                                                );
                                              },
                                              text: 'Select Min price',
                                            ),
                                            Text('Maximum price: $_maximumPrice'),
                                            MainButton(
                                              width: 200,
                                              color: Colors.lightBlue,
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                final maximumPrice = await _showMaxPricePickerDialog();
                                                setState(
                                                  () {
                                                    _maximumPrice = maximumPrice;
                                                  },
                                                );
                                              },
                                              text: 'Select Max price',
                                            ),
                                            const SizedBox(height: 30),
                                            MainButton(
                                              color: Colors.lightBlue,
                                              textColor: Colors.white,
                                              width: 120,
                                              text: 'Filter',
                                              onPressed: () {
                                                BlocProvider.of<HomeCubit>(context).filter(
                                                  filterType: FilterType.price,
                                                  minimPrice: _minimumPrice,
                                                  maxPrice: _maximumPrice,
                                                );
                                                AutoRouter.of(context).popForced();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                          FilterItem(
                            filterType: FilterType.location,
                            icon: Icons.location_on,
                            onPressed: () =>
                                BlocProvider.of<HomeCubit>(context).filter(filterType: FilterType.location),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isPagePriceFiltered)
                    MainButton(
                      width: 200,
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      text: 'Reset Filters',
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context).resetFilter();
                      },
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 60),
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        return PropertyItem(
                          listing: listings[index],
                          onPressed: () => AutoRouter.of(context).push(ListingRoute(listing: listings[index])),
                          onFavoriteIconPressed: () {
                            setState(() {
                              _isSaved = !_isSaved;
                            });
                          },
                          isSaved: _isSaved,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.onPressed,
    required this.listing,
    required this.isSaved,
    required this.onFavoriteIconPressed,
  });

  final VoidCallback onPressed;
  final Listing listing;
  final VoidCallback onFavoriteIconPressed;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.file(
                      listing.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 6),
                                  child: ListingPrice(
                                    property: listing.property,
                                    textSize: 20,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${listing.property.propertyType.name.capitalize()} ${listing.property.areaSize} m²',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(20, 112, 161, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Color.fromRGBO(20, 112, 161, 1),
                                      size: 20,
                                    ),
                                    Flexible(
                                      child: Text(
                                        listing.property.location,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(20, 112, 161, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: listing.property.listingType == ListingType.sale
                                          ? Colors.lightGreen
                                          : const Color.fromARGB(255, 132, 101, 216),
                                      size: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        'For ${listing.property.listingType.name.capitalize()}',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(20, 112, 161, 1),
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     InkWell(
                        //       onTap: onFavoriteIconPressed,
                        //       child: isSaved
                        //           ? const Icon(
                        //               Icons.favorite,
                        //               color: Color.fromRGBO(20, 112, 161, 1),
                        //               size: 30,
                        //             )
                        //           : const Icon(
                        //               Icons.favorite_border_outlined,
                        //               color: Color.fromRGBO(20, 112, 161, 1),
                        //               size: 30,
                        //             ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            color: Color.fromRGBO(70, 179, 231, 1),
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

class PricePickerDialog extends StatefulWidget {
  const PricePickerDialog({
    super.key,
    required this.initialPrice,
    required this.range,
  });
  final double initialPrice;
  final Range range;

  @override
  State<PricePickerDialog> createState() => _PricePickerDialogState();
}

class _PricePickerDialogState extends State<PricePickerDialog> {
  late double _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.initialPrice; // Initialize with the provided initial price
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Price"),
      content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Selected Price: ${_selectedPrice.round()}"), // Display the selected price
            Slider(
              value: _selectedPrice,
              min: widget.range.min,
              max: widget.range.max,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _selectedPrice = value;
                });
              },
            ),
          ],
        );
      }),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedPrice); // Return the selected price
          },
          child: const Text("Done"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null); // Dismiss without any selection
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
