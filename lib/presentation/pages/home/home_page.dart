import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/presentation/widgets/app_toast.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_drawer.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  List<ListingData> listings = [];
  List<String> languages = [];
  bool _isPageFiltered = false;
  RangeValues priceRange = const RangeValues(0, 100000);

  // Active filter selections.
  PropertyType? _propertyType;
  ListingType? _listingType;
  RangeValues? _priceFilter;

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
    BlocProvider.of<HomeCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, BaseState>(
      listener: (context, state) {
        if (state is ListingAddedToFavoritesState) {
          setState(() {
            listings[state.index] = ListingData(
              listing: listings[state.index].listing,
              isSaved: true,
            );
          });
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingAddedToFavorites,
            Icons.favorite_rounded,
            AppColors.success,
          );
        } else if (state is ListingRemovedToFavoritesState) {
          setState(() {
            listings[state.index] = ListingData(
              listing: listings[state.index].listing,
              isSaved: false,
            );
          });
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingRemovedFromFavorites,
            Icons.favorite_border_rounded,
            AppColors.textSecondary,
          );
        } else if (state is ListingAlreadyInFavoritesState) {
          setState(() {
            listings[state.index] = ListingData(
              listing: listings[state.index].listing,
              isSaved: true,
            );
          });
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingAlreadyInFavorites,
            Icons.info_outline_rounded,
            AppColors.warning,
          );
        } else if (state is ListingAlreadyRemovedFromFavoritesState) {
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingAlreadyRemovedFromFavorites,
            Icons.info_outline_rounded,
            AppColors.warning,
          );
        } else if (state is SomethingWentWrongState) {
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).somethingWrong,
            Icons.error_outline_rounded,
            AppColors.error,
          );
        }
      },
      builder: (context, state) {
        if (state is DataLoadedState) {
          listings = state.listings;
          languages = state.languages;
          priceRange = state.priceRange;
          _isPageFiltered = state.isPageFiltered;
          user = state.user;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            backgroundColor: AppColors.surface,
            floatingActionButton: user.type == AccountType.propertyOwner
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () => AutoRouter.of(context).push(const NewPropertyRoute()),
                      child: const Icon(Icons.add_rounded, size: 28),
                    ),
                  )
                : null,
            appBar: MainAppBar(title: AppLocalizations.of(context).appTitle),
            drawer: MainDrawer(languages: languages),
            body: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () {
                unawaited(BlocProvider.of<HomeCubit>(context).refresh());
                return Future<void>.value();
              },
              child: Column(
                children: [
                  // ── Filter Toolbar ─────────────────────────────
                  _FilterToolbar(
                    propertyType: _propertyType,
                    listingType: _listingType,
                    priceFilter: _priceFilter,
                    isFiltered: _isPageFiltered,
                    onOpenFilters: () => _showFiltersBottomSheet(context),
                    onClearPropertyType: () {
                      setState(() => _propertyType = null);
                      _applyCurrentFilters();
                    },
                    onClearListingType: () {
                      setState(() => _listingType = null);
                      _applyCurrentFilters();
                    },
                    onClearPrice: () {
                      setState(() => _priceFilter = null);
                      _applyCurrentFilters();
                    },
                  ),

                  // ── Property List ────────────────────────────
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80, top: 4),
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        return PropertyItem(
                          listing: listings[index].listing,
                          onPressed: () =>
                              AutoRouter.of(context).push(ListingRoute(listing: listings[index].listing, user: user)),
                          onFavoriteIconPressed: () {
                            if (listings[index].isSaved) {
                              BlocProvider.of<HomeCubit>(context)
                                  .removeListingToFavorites(id: listings[index].listing.property.id, index: index);
                            } else {
                              BlocProvider.of<HomeCubit>(context)
                                  .addListingToFavorites(id: listings[index].listing.property.id, index: index);
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
        );
      },
    );
  }

  void _showThemedSnackBar(BuildContext context, String message, IconData icon, Color accentColor) {
    AppToast.show(
      context,
      message: message,
      icon: icon,
      accentColor: accentColor,
    );
  }

  void _applyCurrentFilters() {
    BlocProvider.of<HomeCubit>(context).applyFilters(
      propertyType: _propertyType,
      listingType: _listingType,
      minPrice: _priceFilter?.start,
      maxPrice: _priceFilter?.end,
    );
  }

  Future<void> _showFiltersBottomSheet(BuildContext context) async {
    PropertyType? draftPropertyType = _propertyType;
    ListingType? draftListingType = _listingType;
    RangeValues draftPrice = _priceFilter ?? priceRange;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (bottomSheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 12,
                bottom: 24 + MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    AppLocalizations.of(context).filters,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Property Type
                  _FilterSectionLabel(
                    text: AppLocalizations.of(context).propertyType,
                  ),
                  const SizedBox(height: 10),
                  _SegmentedSelector<PropertyType?>(
                    value: draftPropertyType,
                    options: [
                      _SegmentOption(
                        value: null,
                        label: AppLocalizations.of(context).any,
                        icon: Icons.apps_rounded,
                      ),
                      _SegmentOption(
                        value: PropertyType.house,
                        label: AppLocalizations.of(context).house.capitalize(),
                        icon: Icons.home_rounded,
                      ),
                      _SegmentOption(
                        value: PropertyType.apartment,
                        label: AppLocalizations.of(context).apartment.capitalize(),
                        icon: Icons.apartment_rounded,
                      ),
                    ],
                    onChanged: (v) => setSheetState(() => draftPropertyType = v),
                  ),
                  const SizedBox(height: 22),

                  // Listing Type
                  _FilterSectionLabel(
                    text: AppLocalizations.of(context).listType,
                  ),
                  const SizedBox(height: 10),
                  _SegmentedSelector<ListingType?>(
                    value: draftListingType,
                    options: [
                      _SegmentOption(
                        value: null,
                        label: AppLocalizations.of(context).any,
                        icon: Icons.apps_rounded,
                      ),
                      _SegmentOption(
                        value: ListingType.rent,
                        label: AppLocalizations.of(context).rent.capitalize(),
                        icon: Icons.home_work_rounded,
                      ),
                      _SegmentOption(
                        value: ListingType.sale,
                        label: AppLocalizations.of(context).sale.capitalize(),
                        icon: Icons.local_offer_rounded,
                      ),
                    ],
                    onChanged: (v) => setSheetState(() => draftListingType = v),
                  ),
                  const SizedBox(height: 22),

                  // Price Range
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _FilterSectionLabel(
                        text: AppLocalizations.of(context).priceRange,
                      ),
                      Text(
                        '\$${draftPrice.start.round()} – \$${draftPrice.end.round()}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: draftPrice,
                    min: priceRange.start,
                    max: priceRange.end == priceRange.start ? priceRange.start + 1 : priceRange.end,
                    divisions: 100,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.divider,
                    labels: RangeLabels(
                      '\$${draftPrice.start.round()}',
                      '\$${draftPrice.end.round()}',
                    ),
                    onChanged: (values) => setSheetState(() => draftPrice = values),
                  ),
                  const SizedBox(height: 16),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          isOutlined: true,
                          text: AppLocalizations.of(context).reset,
                          onPressed: () {
                            setSheetState(() {
                              draftPropertyType = null;
                              draftListingType = null;
                              draftPrice = priceRange;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MainButton(
                          isGradient: true,
                          text: AppLocalizations.of(context).applyLabel,
                          onPressed: () {
                            setState(() {
                              _propertyType = draftPropertyType;
                              _listingType = draftListingType;
                              final usingFullRange =
                                  draftPrice.start <= priceRange.start && draftPrice.end >= priceRange.end;
                              _priceFilter = usingFullRange ? null : draftPrice;
                            });
                            _applyCurrentFilters();
                            Navigator.of(bottomSheetContext).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ── Filter Toolbar ─────────────────────────────────────────────────
class _FilterToolbar extends StatelessWidget {
  const _FilterToolbar({
    required this.propertyType,
    required this.listingType,
    required this.priceFilter,
    required this.isFiltered,
    required this.onOpenFilters,
    required this.onClearPropertyType,
    required this.onClearListingType,
    required this.onClearPrice,
  });

  final PropertyType? propertyType;
  final ListingType? listingType;
  final RangeValues? priceFilter;
  final bool isFiltered;
  final VoidCallback onOpenFilters;
  final VoidCallback onClearPropertyType;
  final VoidCallback onClearListingType;
  final VoidCallback onClearPrice;

  @override
  Widget build(BuildContext context) {
    final hasActive = propertyType != null || listingType != null || priceFilter != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          // Primary "Filters" button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onOpenFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.tune_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      AppLocalizations.of(context).filters,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    if (hasActive) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Active filter chips
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (propertyType != null)
                    _ActiveChip(
                      icon: propertyType == PropertyType.house ? Icons.home_rounded : Icons.apartment_rounded,
                      label: propertyType!.name.translate(context, propertyType!.name).capitalize(),
                      onRemove: onClearPropertyType,
                    ),
                  if (listingType != null)
                    _ActiveChip(
                      icon: listingType == ListingType.rent ? Icons.home_work_rounded : Icons.local_offer_rounded,
                      label: listingType!.name.translate(context, listingType!.name).capitalize(),
                      onRemove: onClearListingType,
                    ),
                  if (priceFilter != null)
                    _ActiveChip(
                      icon: Icons.attach_money_rounded,
                      label: '\$${priceFilter!.start.round()}–\$${priceFilter!.end.round()}',
                      onRemove: onClearPrice,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Active Filter Chip ─────────────────────────────────────────────
class _ActiveChip extends StatelessWidget {
  const _ActiveChip({
    required this.icon,
    required this.label,
    required this.onRemove,
  });

  final IconData icon;
  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 2),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onRemove,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filter Section Label ───────────────────────────────────────────
class _FilterSectionLabel extends StatelessWidget {
  const _FilterSectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    );
  }
}

// ── Segmented Selector ─────────────────────────────────────────────
class _SegmentOption<T> {
  const _SegmentOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final T value;
  final String label;
  final IconData icon;
}

class _SegmentedSelector<T> extends StatelessWidget {
  const _SegmentedSelector({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final List<_SegmentOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = option.value == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option.value),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.cardBackground : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.10),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      option.icon,
                      size: 16,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        option.label,
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
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
        }).toList(),
      ),
    );
  }
}

// ── Property Item ──────────────────────────────────────────────────
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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cardBackground,
          boxShadow: AppColors.cardShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Hero(
                  tag: 'property_${listing.property.id}',
                  child: Image.file(
                    listing.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    ListingPrice(
                      property: listing.property,
                      textSize: 20,
                    ),
                    const SizedBox(height: 6),

                    // Type + Size
                    Text(
                      '${listing.property.propertyType.name.translate(context, listing.property.propertyType.name).capitalize()} · ${listing.property.areaSize} m²',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.textTertiary,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            listing.property.location,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Listing type badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: (listing.property.listingType == ListingType.sale
                                ? AppColors.saleIndicator
                                : AppColors.rentIndicator)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${AppLocalizations.of(context).perntru} ${listing.property.listingType.name.translate(context, listing.property.listingType.name).capitalize()}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: listing.property.listingType == ListingType.sale
                              ? AppColors.saleIndicator
                              : AppColors.rentIndicator,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Favorite button
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: onFavoriteIconPressed,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            key: ValueKey<bool>(isSaved),
                            color: isSaved ? AppColors.error : AppColors.textTertiary,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
