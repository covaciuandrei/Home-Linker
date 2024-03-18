import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/new_property/new_property_cubit.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/dropdown_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(32.0),
    );
    return BlocConsumer<NewPropertyCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const MainAppBar(title: 'Add a new Property'),
          body: BlueShadowBackground(
            child: Container(
              // color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              // height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30),
                      // color: Colors.lightBlue,
                      // height:
                      //     (MediaQuery.of(context).size.height - kToolbarHeight) /
                      //         2,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              File? pickedImage =
                                  await BlocProvider.of<NewPropertyCubit>(
                                          context)
                                      .uploadImage();
                              if (pickedImage != null) {
                                setState(() {
                                  _selectedImage = pickedImage;
                                });
                              }
                            },
                            child: Container(
                              width: 196,
                              height: 168,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    )
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
                                File? pickedImage =
                                    await BlocProvider.of<NewPropertyCubit>(
                                            context)
                                        .uploadImage();
                                if (pickedImage != null) {
                                  setState(() {
                                    _selectedImage = pickedImage;
                                  });
                                }
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.purple,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                  selectedValue; // Update parkingSpaces with the returned value
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
                                              bedrooms =
                                                  selectedValue; // Update parkingSpaces with the returned value
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
                                              bathrooms =
                                                  selectedValue; // Update parkingSpaces with the returned value
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
                                              parkingSpaces =
                                                  selectedValue; // Update parkingSpaces with the returned value
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
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            // isDense: true,
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
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            // isDense: true,
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
                            // TextField(
                            //   keyboardType: TextInputType.multiline,
                            //   maxLines: null,
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: const MultiLineInputBox(),
                            ),
                            const SizedBox(height: 20),
                            MainButton(
                              text: 'Add Property',
                              onPressed: () {},
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
        );
      },
    );
  }
}

class MultiLineInputBox extends StatelessWidget {
  const MultiLineInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          // minWidth: _contextWidth(),
          // maxWidth: _contextWidth(),
          // minHeight: AppMeasurements.isLandscapePhone(context) ? 25.0 : 25.0,
          maxHeight: 55.0,
        ),
        child: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,

          // here's the actual text box
          child: TextField(
            cursorColor: Colors.white,
            style: TextStyle(fontSize: 16, color: Colors.white),
            keyboardType: TextInputType.multiline,
            maxLines: null, //grow automatically
            // focusNode: mrFocus,
            // controller: _textController,
            // onSubmitted: currentIsComposing ? _handleSubmitted : null,
            decoration: InputDecoration.collapsed(
                hintText: 'Please enter the description',
                hintStyle: TextStyle(color: Colors.white)),
          ),
          // ends the actual text box
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
