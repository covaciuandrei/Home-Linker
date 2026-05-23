import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/new_property/new_property_cubit.dart';
import 'package:homelinker/models/place_location.dart';
import 'package:homelinker/models/property.dart';
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
    priceTextController.addListener(_recomputeButtonEnabled);
    areaTextController.addListener(_recomputeButtonEnabled);
    descriptionTextController.addListener(_recomputeButtonEnabled);
    super.initState();
  }

  @override
  void dispose() {
    priceTextController.dispose();
    areaTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  // ── Validation helpers ───────────────────────────────────────────
  double? _parsedPrice() => double.tryParse(priceTextController.text.trim());
  int? _parsedArea() => int.tryParse(areaTextController.text.trim());

  bool _isFormValid() {
    final price = _parsedPrice();
    final area = _parsedArea();
    return _selectedImage != null && price != null && price > 0 && area != null && area > 0;
  }

  void _recomputeButtonEnabled() {
    final enabled = _isFormValid();
    if (enabled != _isButtonEnabled) {
      setState(() => _isButtonEnabled = enabled);
    }
  }

  String? _firstValidationError(BuildContext context) {
    final l = AppLocalizations.of(context);
    if (_selectedImage == null) return l.selectPhoto;
    final price = _parsedPrice();
    if (price == null || price <= 0) return l.invalidPrice;
    final area = _parsedArea();
    if (area == null || area <= 0) return l.invalidAreaSize;
    return null;
  }

  void _showValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPropertyCubit, BaseState>(
      listener: (context, state) {
        if (state is PropertyAddedSuccessfullyState) {
          debugPrint('[NewProperty] PropertyAddedSuccessfullyState received -> popping');
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);
          } else {
            AutoRouter.of(context).popForced<bool>(true);
          }
        } else if (state is NoFileChosenState) {}
      },
      builder: (context, state) {
        if (state is FileUploadedState) {
          _selectedImage = state.imageFile;
        } else if (state is LocationPickedState) {
          _location = state.location;
        }
        _isButtonEnabled = _isFormValid();
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            backgroundColor: AppColors.surface,
            appBar: MainAppBar(title: AppLocalizations.of(context).addProperty),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Photo Upload Card ─────────────────────────
                  _SectionCard(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async => await BlocProvider.of<NewPropertyCubit>(context).pickPicture(),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.divider,
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(alpha: 0.08),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          size: 32,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        AppLocalizations.of(context).uploadPhoto,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        // Location info chip
                        if (_location != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _location!.address,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Location buttons
                        Row(
                          children: [
                            Expanded(
                              child: _OutlinedActionButton(
                                icon: Icons.my_location_rounded,
                                label: AppLocalizations.of(context).currentLocation,
                                onPressed: () => BlocProvider.of<NewPropertyCubit>(context).getCurrentLocation(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _OutlinedActionButton(
                                icon: Icons.map_rounded,
                                label: AppLocalizations.of(context).selectOnMap,
                                onPressed: () async {
                                  if (_location == null) {
                                    pickedLocation = await AutoRouter.of(context).push(MapRoute()) as LatLng?;
                                  } else {
                                    pickedLocation =
                                        await AutoRouter.of(context).push(MapRoute(location: _location!)) as LatLng?;
                                  }
                                  // ignore: use_build_context_synchronously
                                  await BlocProvider.of<NewPropertyCubit>(context).getSelectedLocation(
                                      coordonate: LatLng(pickedLocation!.latitude, pickedLocation!.longitude));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Property Details Card ─────────────────────
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).addProperty,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 20),

                        // Type & Listing
                        Row(
                          children: [
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).propertyType,
                                child: DropdownPicker(
                                  onValueChanged: (value) => propertyType = value,
                                  list: [PropertyType.apartment.name, PropertyType.house.name],
                                  isDarkMode: false,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).listType,
                                child: DropdownPicker(
                                  onValueChanged: (value) => listingType = value,
                                  list: [ListingType.sale.name, ListingType.rent.name],
                                  isDarkMode: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Year & Bedrooms
                        Row(
                          children: [
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).constructionYear,
                                child: _NumberChip(
                                  value: constructionYear,
                                  onTap: () async {
                                    int? val = await _showNumberPickerDialog(
                                      context: context,
                                      number: constructionYear,
                                      minValue: 1900,
                                      maxValue: DateTime.now().year,
                                    );
                                    if (val != null) setState(() => constructionYear = val);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).bedrooms.capitalize(),
                                child: _NumberChip(
                                  value: bedrooms,
                                  onTap: () async {
                                    int? val = await _showNumberPickerDialog(
                                      context: context,
                                      number: bedrooms,
                                      minValue: 1,
                                      maxValue: 20,
                                    );
                                    if (val != null) setState(() => bedrooms = val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Bathrooms & Parking
                        Row(
                          children: [
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).bathrooms.capitalize(),
                                child: _NumberChip(
                                  value: bathrooms,
                                  onTap: () async {
                                    int? val = await _showNumberPickerDialog(
                                      context: context,
                                      number: bathrooms,
                                      minValue: 1,
                                      maxValue: 10,
                                    );
                                    if (val != null) setState(() => bathrooms = val);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).parkingspaces.capitalize(),
                                child: _NumberChip(
                                  value: parkingSpaces,
                                  onTap: () async {
                                    int? val = await _showNumberPickerDialog(
                                      context: context,
                                      number: parkingSpaces,
                                      minValue: 0,
                                      maxValue: 10,
                                    );
                                    if (val != null) setState(() => parkingSpaces = val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Price & Area
                        Row(
                          children: [
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).price,
                                child: _CleanTextField(
                                  controller: priceTextController,
                                  hintText: '\$0',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FormField(
                                label: AppLocalizations.of(context).areaSize,
                                child: _CleanTextField(
                                  controller: areaTextController,
                                  hintText: '0 m²',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Description Card ──────────────────────────
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).description,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: TextField(
                            controller: descriptionTextController,
                            cursorColor: AppColors.primary,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.5,
                                ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              hintText: AppLocalizations.of(context).enterDescription,
                              hintStyle: TextStyle(color: AppColors.textTertiary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Submit Button ─────────────────────────────
                  Center(
                    child: MainButton(
                      isEnabled: _isButtonEnabled,
                      isGradient: true,
                      text: AppLocalizations.of(context).addProperty,
                      icon: Icons.add_home_rounded,
                      onPressed: () {
                        final error = _firstValidationError(context);
                        if (error != null) {
                          _showValidationError(context, error);
                          return;
                        }
                        BlocProvider.of<NewPropertyCubit>(context).addProperty(
                          areaSize: _parsedArea()!,
                          bathrooms: bathrooms,
                          bedrooms: bedrooms,
                          constructionYear: constructionYear,
                          description: descriptionTextController.text.trim(),
                          selectedImage: _selectedImage!,
                          propertyType: propertyType,
                          location: _location != null ? jsonEncode(_location!.toJson()) : '',
                          parkingSpaces: parkingSpaces,
                          price: _parsedPrice()!,
                          listingType: listingType,
                        );
                      },
                      width: 240,
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

// ── Section Card ───────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),
      child: child,
    );
  }
}

// ── Form Field with label ──────────────────────────────────────────
class _FormField extends StatelessWidget {
  const _FormField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

// ── Number Chip ────────────────────────────────────────────────────
class _NumberChip extends StatelessWidget {
  const _NumberChip({required this.value, required this.onTap});

  final int value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$value',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textTertiary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Clean Text Field ───────────────────────────────────────────────
class _CleanTextField extends StatelessWidget {
  const _CleanTextField({
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primary,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

// ── Outlined Action Button ─────────────────────────────────────────
class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            color: AppColors.primary.withValues(alpha: 0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Number Picker Dialog ───────────────────────────────────────────
Future<int?> _showNumberPickerDialog({
  required BuildContext context,
  required int number,
  required int minValue,
  required int maxValue,
}) async {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context).pickValue,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return NumberPicker(
              selectedTextStyle: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
              textStyle: TextStyle(
                color: AppColors.textTertiary,
              ),
              value: number,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: (value) {
                setDialogState(() {
                  number = value;
                });
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(
              AppLocalizations.of(context).cancel,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context).ok,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(number);
            },
          ),
        ],
      );
    },
  );
}
