import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/favorites/favorites_cubit.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/enums/filter_type.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/listing_data.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/range.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_drawer.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget implements AutoRouteWrapper {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<FavoritesCubit>(
      create: (context) => getIt<FavoritesCubit>(),
      child: this,
    );
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<ListingData> listings = [];
  List<String> languages = [];
  bool _isPagePriceFiltered = false;
  double _minimumPrice = 0;
  double _maximumPrice = 0;
  RangeValues priceRange = const RangeValues(0, 100000);
  User user = const User(
    email: '',
    id: '',
    name: '',
    phone: '',
    profilePictureId: '',
    type: AccountType.client,
    twoFactorAuthCode: '',
    is2FaActivated: false,
    favoriteListingsIds: [],
  );

  @override
  void initState() {
    BlocProvider.of<FavoritesCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, BaseState>(
      listener: (context, state) {
        if (state is ListingAddedToFavoritesState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).listingAddedToFavorites),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is ListingRemovedToFavoritesState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).listingRemovedFromFavorites),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is ListingAlreadyInFavoritesState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).listingAlreadyInFavorites),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is ListingAlreadyRemovedFromFavoritesState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).listingAlreadyRemovedFromFavorites),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is SomethingWentWrongState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                AppLocalizations.of(context).somethingWrong,
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DataLoadedState) {
          listings = state.listings;
          languages = state.languages;
          priceRange = state.priceRange;
          _isPagePriceFiltered = state.isPageFiltered;
          user = state.user;
        }
        return GestureDetector(
          onTap: () => BlocProvider.of<FavoritesCubit>(context).resetFilter(),
          child: LoadingScreen(
            loading: state is PendingState,
            child: Scaffold(
              floatingActionButton: user.type == AccountType.propertyOwner
                  ? FloatingActionButton(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      onPressed: () => AutoRouter.of(context).push(const NewPropertyRoute()),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  : null,
              appBar: MainAppBar(title: AppLocalizations.of(context).appTitle),
              drawer: MainDrawer(languages: languages),
              body: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<FavoritesCubit>(context).refresh();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterItem(
                              context: context,
                              filterType: FilterType.house,
                              icon: Icons.home,
                              onPressed: () =>
                                  BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.house),
                            ),
                            FilterItem(
                              context: context,
                              filterType: FilterType.apartment,
                              icon: Icons.apartment_rounded,
                              onPressed: () =>
                                  BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.apartment),
                            ),
                            FilterItem(
                              context: context,
                              filterType: FilterType.rent,
                              icon: Icons.home_work,
                              onPressed: () =>
                                  BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.rent),
                            ),
                            FilterItem(
                              context: context,
                              filterType: FilterType.sale,
                              icon: Icons.local_offer,
                              onPressed: () =>
                                  BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.sale),
                            ),
                            FilterItem(
                              context: context,
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
                                              Text('${AppLocalizations.of(context).minimumPrice}: $_minimumPrice'),
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
                                                text: AppLocalizations.of(context).selectMinimumPrice,
                                              ),
                                              Text('${AppLocalizations.of(context).maximumPrice}: $_maximumPrice'),
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
                                                text: AppLocalizations.of(context).selectMaximumPrice,
                                              ),
                                              const SizedBox(height: 30),
                                              MainButton(
                                                color: Colors.lightBlue,
                                                textColor: Colors.white,
                                                width: 120,
                                                text: AppLocalizations.of(context).filter,
                                                onPressed: () {
                                                  BlocProvider.of<FavoritesCubit>(context).filter(
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
                              context: context,
                              filterType: FilterType.location,
                              icon: Icons.location_on,
                              onPressed: () =>
                                  BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.location),
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
                        text: AppLocalizations.of(context).removeFilter,
                        onPressed: () {
                          BlocProvider.of<FavoritesCubit>(context).resetFilter();
                        },
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 60),
                        itemCount: listings.length,
                        itemBuilder: (context, index) {
                          return PropertyItem(
                            listing: listings[index].listing,
                            onPressed: () =>
                                AutoRouter.of(context).push(ListingRoute(listing: listings[index].listing, user: user)),
                            onFavoriteIconPressed: () {
                              if (listings[index].isSaved) {
                                BlocProvider.of<FavoritesCubit>(context)
                                    .removeListingToFavorites(id: listings[index].listing.property.id);
                              } else {
                                BlocProvider.of<FavoritesCubit>(context)
                                    .addListingToFavorites(id: listings[index].listing.property.id);
                              }
                              setState(() {
                                listings[index] = ListingData(
                                  listing: listings[index].listing,
                                  isSaved: !listings[index].isSaved,
                                );
                              });
                            },
                            isSaved: listings[index].isSaved,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
                                  '${listing.property.propertyType.name.translate(context, listing.property.propertyType.name).capitalize()} ${listing.property.areaSize} m²',
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
                                        '${AppLocalizations.of(context).perntru} ${listing.property.listingType.name.translate(context, listing.property.listingType.name).capitalize()}',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: onFavoriteIconPressed,
                              child: isSaved
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color.fromRGBO(20, 112, 161, 1),
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Color.fromRGBO(20, 112, 161, 1),
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
    required this.context,
  });

  final IconData icon;
  final FilterType filterType;
  final VoidCallback onPressed;
  final BuildContext context;

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
                filterType.name.translate(context, filterType.name).capitalize(),
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
    _selectedPrice = widget.initialPrice;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).selectPrice),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${AppLocalizations.of(context).selectedPrice}: ${_selectedPrice.round()}"),
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
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedPrice);
          },
          child: Text(AppLocalizations.of(context).done),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
