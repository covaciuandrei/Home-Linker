import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/new_property/new_property_cubit.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/dropdown_picker.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:numberpicker/numberpicker.dart';

@RoutePage()
class NewPropertyPage extends StatefulWidget {
  const NewPropertyPage({Key? key}) : super(key: key);

  @override
  State<NewPropertyPage> createState() => _NewPropertyPageState();
}

class _NewPropertyPageState extends State<NewPropertyPage> {
  File? _selectedImage;
  int parkingSpaces = 0;
  int constructionYear = DateTime.now().year;
  int bedrooms = 1;
  int bathrooms = 1;
  String listingType = 'apartment';
  String propertyType = 'sale';
  bool _isButtonEnabled = false;
  final priceTextController = TextEditingController();
  final areaTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

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
          BlocProvider.of<HomeCubit>(context).load();
          AutoRouter.of(context).pop();
        } else if (state is NoFileChosenState) {}
      },
      builder: (context, state) {
        if (state is FileUploadedState) {
          _selectedImage = state.imageFile;
          _isButtonEnabled = true;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            appBar: const MainAppBar(title: 'Add a new Property'),
            body: BlueShadowBackground(
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
                              onTap: () async {
                                await BlocProvider.of<NewPropertyCubit>(context)
                                    .pickPicture();
                              },
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: MainButton(
                                onPressed: () async {
                                  await BlocProvider.of<NewPropertyCubit>(
                                          context)
                                      .pickPicture();
                                },
                                text: 'Upload a photo',
                                icon: Icons.add_a_photo_rounded,
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Property type',
                                          style: TextStyle(
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
                                        const Text(
                                          'List Type',
                                          style: TextStyle(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Construction Year',
                                          style: TextStyle(
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
                                            int? selectedValue =
                                                await _showAlertDialog(
                                              context: context,
                                              number: constructionYear,
                                              minValue: 1900,
                                              maxValue: DateTime.now().year,
                                            );
                                            if (selectedValue != null) {
                                              setState(() {
                                                constructionYear =
                                                    selectedValue;
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
                                        const Text(
                                          'Bedrooms',
                                          style: TextStyle(
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
                                            int? selectedValue =
                                                await _showAlertDialog(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Bathrooms',
                                          style: TextStyle(
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
                                            int? selectedValue =
                                                await _showAlertDialog(
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
                                        const Text(
                                          'Parking Spaces',
                                          style: TextStyle(
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
                                            int? selectedValue =
                                                await _showAlertDialog(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Price',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          width: 140,
                                          child: TextField(
                                            controller: priceTextController,
                                            cursorColor: Colors.white,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 40),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 8, 8, 8),
                                              labelText: "Price",
                                              focusColor: Colors.white,
                                              labelStyle: const TextStyle(
                                                  color: Colors.white),
                                              focusedBorder: border,
                                              enabledBorder: border,
                                              errorBorder: border,
                                              border: border,
                                              disabledBorder: border,
                                              focusedErrorBorder: border,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Area Size',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          width: 140,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: areaTextController,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 40),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 8, 8, 8),
                                              labelText: "Area Size",
                                              focusColor: Colors.white,
                                              labelStyle: const TextStyle(
                                                  color: Colors.white),
                                              focusedBorder: border,
                                              enabledBorder: border,
                                              errorBorder: border,
                                              border: border,
                                              disabledBorder: border,
                                              focusedErrorBorder: border,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: MultiLineInputBox(
                                  descriptionTextController:
                                      descriptionTextController,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MainButton(
                                isEnabled: _isButtonEnabled,
                                text: 'Add Property',
                                onPressed: () {
                                  BlocProvider.of<NewPropertyCubit>(context)
                                      .addProperty(
                                    areaSize:
                                        int.parse(areaTextController.text),
                                    bathrooms: bathrooms,
                                    bedrooms: bedrooms,
                                    constructionYear: constructionYear,
                                    description: descriptionTextController.text,
                                    selectedImage: _selectedImage!,
                                    listingType: listingType,
                                    location: 'location',
                                    parkingSpaces: parkingSpaces,
                                    price:
                                        double.parse(priceTextController.text),
                                    propertyType: propertyType,
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
            decoration: const InputDecoration.collapsed(
                hintText: 'Please enter the description',
                hintStyle: TextStyle(color: Colors.white)),
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
        title: const Text("Pick a value"),
        content: StatefulBuilder(
          builder: (context, sBsetState) {
            return NumberPicker(
              selectedTextStyle: const TextStyle(color: Colors.red),
              value: number,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: (value) {
                sBsetState(() {
                  number = value; // Update number here
                });
              },
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(number);
            },
          )
        ],
      );
    },
  );
}
