import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/new_property/new_property_cubit.dart';
import 'package:homelinker/models/place_location.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/dropdown_picker.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/utils/extension_methods.dart';
import 'package:numberpicker/numberpicker.dart';

@RoutePage()
class NewPropertyPage extends StatefulWidget implements AutoRouteWrapper {
  const NewPropertyPage({super.key});

  @override
  State<NewPropertyPage> createState() => _NewPropertyPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<NewPropertyCubit>(
      create: (context) => getIt<NewPropertyCubit>(),
      child: this,
    );
  }
}

class _NewPropertyPageState extends State<NewPropertyPage> {
  File? _selectedImage;
  int parkingSpaces = 0;
  int constructionYear = DateTime.now().year;
  int bedrooms = 1;
  int bathrooms = 1;

  String propertyType = PropertyType.apartment.name;
  String listingType = ListingType.sale.name;

  bool _isButtonEnabled = false;
  final priceTextController = TextEditingController();
  final areaTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  PlaceLocation? _location;
  LatLng? pickedLocation;

  @override
  void initState() {
    BlocProvider.of<NewPropertyCubit>(context).loadPage();

    super.initState();
  }

  Image genratePreviowWidget(File file) {
    return Image.file(
      file,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(32.0),
    );
    return BlocConsumer<NewPropertyCubit, BaseState>(
      listener: (context, state) {
        if (state is PropertyAddedSuccessfullyState) {
          BlocProvider.of<HomeCubit>(context).load(forceRefresh: true);
          AutoRouter.of(context).popForced();
        } else if (state is NoFileChosenState) {}
      },
      builder: (context, state) {
        if (state is FileUploadedState) {
          _selectedImage = state.imageFile;
          _isButtonEnabled = true;
        } else if (state is LocationPickedState) {
          _location = state.location;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            appBar: MainAppBar(title: AppLocalizations.of(context).addProperty),
            body: SingleChildScrollView(
              child: BlueShadowBackground(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async => await BlocProvider.of<NewPropertyCubit>(context).pickPicture(),
                                child: Container(
                                  width: 196,
                                  height: 168,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: _selectedImage != null
                                      ? genratePreviowWidget(_selectedImage!)
                                      : const Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 100),
                                child: MainButton(
                                  onPressed: () async {
                                    await BlocProvider.of<NewPropertyCubit>(context).pickPicture();
                                  },
                                  text: AppLocalizations.of(context).uploadPhoto,
                                  icon: Icons.add_a_photo_rounded,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _location != null ? Text(_location!.address) : const Text(''),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainButton(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    onPressed: () => BlocProvider.of<NewPropertyCubit>(context).getCurrentLocation(),
                                    icon: Icons.location_on,
                                    text: AppLocalizations.of(context).currentLocation,
                                  ),
                                  MainButton(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    onPressed: () async {
                                      if (_location == null) {
                                        pickedLocation = await AutoRouter.of(context).push(MapRoute()) as LatLng?;
                                      } else {
                                        pickedLocation = await AutoRouter.of(context)
                                            .push(MapRoute(location: _location!)) as LatLng?;
                                      }

                                      // ignore: use_build_context_synchronously
                                      await BlocProvider.of<NewPropertyCubit>(context).getSelectedLocation(
                                          coordonate: LatLng(pickedLocation!.latitude, pickedLocation!.longitude));
                                    },
                                    icon: Icons.map,
                                    text: AppLocalizations.of(context).selectOnMap,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).propertyType,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          DropdownPicker(
                                            onValueChanged: (value) {
                                              propertyType = value;
                                            },
                                            list: [
                                              PropertyType.apartment.name,
                                              PropertyType.house.name,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).listType,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          DropdownPicker(
                                            onValueChanged: (value) {
                                              listingType = value;
                                            },
                                            list: [
                                              ListingType.sale.name,
                                              ListingType.rent.name,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).constructionYear,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          MainButton(
                                            width: 100,
                                            text: '$constructionYear',
                                            onPressed: () async {
                                              int? selectedValue = await _showAlertDialog(
                                                context: context,
                                                number: constructionYear,
                                                minValue: 1900,
                                                maxValue: DateTime.now().year,
                                              );
                                              if (selectedValue != null) {
                                                setState(() {
                                                  constructionYear = selectedValue;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).bedrooms.capitalize(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          MainButton(
                                            width: 100,
                                            text: '$bedrooms',
                                            onPressed: () async {
                                              int? selectedValue = await _showAlertDialog(
                                                context: context,
                                                number: bedrooms,
                                                minValue: 1,
                                                maxValue: 20,
                                              );
                                              if (selectedValue != null) {
                                                setState(() {
                                                  bedrooms = selectedValue;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).bathrooms.capitalize(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          MainButton(
                                            width: 100,
                                            text: '$bathrooms',
                                            onPressed: () async {
                                              int? selectedValue = await _showAlertDialog(
                                                context: context,
                                                number: bathrooms,
                                                minValue: 1,
                                                maxValue: 10,
                                              );
                                              if (selectedValue != null) {
                                                setState(() {
                                                  bathrooms = selectedValue;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).parkingspaces.capitalize(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          MainButton(
                                            width: 100,
                                            text: '$parkingSpaces',
                                            onPressed: () async {
                                              int? selectedValue = await _showAlertDialog(
                                                context: context,
                                                number: parkingSpaces,
                                                minValue: 0,
                                                maxValue: 10,
                                              );
                                              if (selectedValue != null) {
                                                setState(() {
                                                  parkingSpaces = selectedValue;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).price,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            width: 140,
                                            child: TextField(
                                              controller: priceTextController,
                                              cursorColor: Colors.white,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                constraints: const BoxConstraints(maxHeight: 40),
                                                contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                                                labelText: AppLocalizations.of(context).price,
                                                focusColor: Colors.white,
                                                labelStyle: const TextStyle(color: Colors.white),
                                                focusedBorder: border,
                                                enabledBorder: border,
                                                errorBorder: border,
                                                border: border,
                                                disabledBorder: border,
                                                focusedErrorBorder: border,
                                              ),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).areaSize,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            width: 140,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              controller: areaTextController,
                                              cursorColor: Colors.white,
                                              decoration: InputDecoration(
                                                constraints: const BoxConstraints(maxHeight: 40),
                                                contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                                                labelText: AppLocalizations.of(context).areaSize,
                                                focusColor: Colors.white,
                                                labelStyle: const TextStyle(color: Colors.white),
                                                focusedBorder: border,
                                                enabledBorder: border,
                                                errorBorder: border,
                                                border: border,
                                                disabledBorder: border,
                                                focusedErrorBorder: border,
                                              ),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: MultiLineInputBox(
                                    descriptionTextController: descriptionTextController,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                MainButton(
                                  isEnabled: _isButtonEnabled,
                                  text: AppLocalizations.of(context).addProperty,
                                  onPressed: () {
                                    BlocProvider.of<NewPropertyCubit>(context).addProperty(
                                      areaSize: int.parse(areaTextController.text),
                                      bathrooms: bathrooms,
                                      bedrooms: bedrooms,
                                      constructionYear: constructionYear,
                                      description: descriptionTextController.text,
                                      selectedImage: _selectedImage!,
                                      propertyType: propertyType,
                                      location: jsonEncode(_location!.toJson()),
                                      parkingSpaces: parkingSpaces,
                                      price: double.parse(priceTextController.text),
                                      listingType: listingType,
                                    );
                                  },
                                  width: 200,
                                ),
                                const SizedBox(height: 75),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MultiLineInputBox extends StatefulWidget {
  const MultiLineInputBox({super.key, required this.descriptionTextController});
  final TextEditingController descriptionTextController;
  @override
  State<MultiLineInputBox> createState() => _MultiLineInputBoxState();
}

class _MultiLineInputBoxState extends State<MultiLineInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 55.0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child: TextField(
            controller: widget.descriptionTextController,
            cursorColor: Colors.white,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: AppLocalizations.of(context).enterDescription,
              hintStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

Future<int?> _showAlertDialog({
  required BuildContext context,
  required int number,
  required int minValue,
  required int maxValue,
}) async {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).pickValue),
        content: StatefulBuilder(
          builder: (context, sBsetState) {
            return NumberPicker(
              selectedTextStyle: const TextStyle(color: Colors.red),
              value: number,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: (value) {
                sBsetState(() {
                  number = value;
                });
              },
            );
          },
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context).ok),
            onPressed: () {
              Navigator.of(context).pop(number);
            },
          )
        ],
      );
    },
  );
}
