import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/models/filters.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
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
            appBar: const MainAppBar(title: 'HomeLinker'),
            drawer: const MainDrawer(),
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
                      return PropertyItem(
                        property: properties[index],
                        onPressed: () => AutoRouter.of(context)
                            .push(PropertyRoute(property: properties[index])),
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
        );
      },
    );
  }
}

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.onPressed,
    required this.property,
    required this.isSaved,
    required this.onFavoriteIconPressed,
  });

  final VoidCallback onPressed;
  final Property property;
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
                    child: Image.network(
                      property.imageLink,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 6),
                                  child: ListingPrice(
                                    property: property,
                                    textSize: 20,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${property.propertyType.name.capitalize()} ${property.areaSize} m²',
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
                                        property.location,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(20, 112, 161, 1),
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
                                      color: property.listingType ==
                                              ListingType.sale
                                          ? Colors.lightGreen
                                          : const Color.fromARGB(
                                              255, 132, 101, 216),
                                      size: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'For ${property.listingType.name.capitalize()}',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(20, 112, 161, 1),
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
