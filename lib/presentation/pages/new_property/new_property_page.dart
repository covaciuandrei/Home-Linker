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

@RoutePage()
class NewPropertyPage extends StatefulWidget {
  const NewPropertyPage({Key? key}) : super(key: key);

  @override
  _NewPropertyPageState createState() => _NewPropertyPageState();
}

class _NewPropertyPageState extends State<NewPropertyPage> {
  File? _selectedImage;

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
                                        'Bedrooms',
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
                                        'Bathrooms',
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
                                        'Parking Spaces',
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
                            SizedBox(height: 20),
                            MainButton(
                              text: 'Add Property',
                              onPressed: () {},
                              width: 200,
                            ),
                            SizedBox(height: 200),
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
