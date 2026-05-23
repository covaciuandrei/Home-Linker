import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
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
import 'package:homelinker/presentation/widgets/app_toast.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
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
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingAddedToFavorites,
            Icons.favorite_rounded,
            AppColors.success,
          );
        } else if (state is ListingRemovedToFavoritesState) {
          _showThemedSnackBar(
            context,
            AppLocalizations.of(context).listingRemovedFromFavorites,
            Icons.favorite_border_rounded,
            AppColors.textSecondary,
          );
        } else if (state is ListingAlreadyInFavoritesState) {
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
          priceRange = state.priceRange;
          _isPagePriceFiltered = state.isPageFiltered;
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
            appBar: MainAppBar(title: AppLocalizations.of(context).favorites),
            body: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () {
                unawaited(BlocProvider.of<FavoritesCubit>(context).refresh());
                return Future<void>.value();
              },
              child: Column(
                children: [
                  // ── Filter Chips ─────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _FilterItem(
                            filterType: FilterType.house,
                            icon: Icons.home_rounded,
                            onPressed: () =>
                                BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.house),
                          ),
                          _FilterItem(
                            filterType: FilterType.apartment,
                            icon: Icons.apartment_rounded,
                            onPressed: () =>
                                BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.apartment),
                          ),
                          _FilterItem(
                            filterType: FilterType.rent,
                            icon: Icons.home_work_rounded,
                            onPressed: () =>
                                BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.rent),
                          ),
                          _FilterItem(
                            filterType: FilterType.sale,
                            icon: Icons.local_offer_rounded,
                            onPressed: () =>
                                BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.sale),
                          ),
                          _FilterItem(
                            filterType: FilterType.price,
                            icon: Icons.attach_money_rounded,
                            onPressed: () async {
                              await _showPriceFilterBottomSheet(context);
                            },
                          ),
                          _FilterItem(
                            filterType: FilterType.location,
                            icon: Icons.location_on_rounded,
                            onPressed: () =>
                                BlocProvider.of<FavoritesCubit>(context).filter(filterType: FilterType.location),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Remove Filter Button ─────────────────────
                  if (_isPagePriceFiltered)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: MainButton(
                        width: 200,
                        height: 38,
                        isOutlined: true,
                        text: AppLocalizations.of(context).removeFilter,
                        icon: Icons.close_rounded,
                        onPressed: () {
                          BlocProvider.of<FavoritesCubit>(context).resetFilter();
                        },
                      ),
                    ),

                  // ── Empty State ──────────────────────────────
                  if (listings.isEmpty && state is! PendingState)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border_rounded,
                              size: 64,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context).noResults,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // ── Property List ────────────────────────────
                  if (listings.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80, top: 4),
                        itemCount: listings.length,
                        itemBuilder: (context, index) {
                          return _PropertyItem(
                            listing: listings[index].listing,
                            onPressed: () =>
                                AutoRouter.of(context).push(ListingRoute(listing: listings[index].listing, user: user, isSaved: listings[index].isSaved)),
                            onFavoriteIconPressed: () {
                              if (listings[index].isSaved) {
                                BlocProvider.of<FavoritesCubit>(context)
                                    .removeListingToFavorites(id: listings[index].listing.property.id);
                              } else {
                                BlocProvider.of<FavoritesCubit>(context)
                                    .addListingToFavorites(id: listings[index].listing.property.id);
                              }
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

  Future<void> _showPriceFilterBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => StatefulBuilder(
        builder: (bottomSheetContext, setModalState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).selectPrice,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 24),
                _PriceInputRow(
                  label: AppLocalizations.of(context).minimumPrice,
                  value: _minimumPrice,
                  onTap: () async {
                    final price = await _showPricePickerDialog(
                      _minimumPrice,
                      Range(min: priceRange.start, max: priceRange.end),
                    );
                    setModalState(() => _minimumPrice = price);
                  },
                ),
                const SizedBox(height: 12),
                _PriceInputRow(
                  label: AppLocalizations.of(context).maximumPrice,
                  value: _maximumPrice,
                  onTap: () async {
                    final price = await _showPricePickerDialog(
                      _maximumPrice,
                      Range(min: priceRange.start, max: priceRange.end),
                    );
                    setModalState(() => _maximumPrice = price);
                  },
                ),
                const SizedBox(height: 28),
                MainButton(
                  isGradient: true,
                  text: AppLocalizations.of(context).filter,
                  onPressed: () {
                    BlocProvider.of<FavoritesCubit>(context).filter(
                      filterType: FilterType.price,
                      minimPrice: _minimumPrice,
                      maxPrice: _maximumPrice,
                    );
                    Navigator.of(bottomSheetContext).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<double> _showPricePickerDialog(double initial, Range range) async {
    final selectedPrice = await showDialog<double>(
      context: context,
      builder: (context) => _PricePickerDialog(
        initialPrice: initial,
        range: range,
      ),
    );
    return selectedPrice ?? initial;
  }
}

// ── Price Input Row ────────────────────────────────────────────────
class _PriceInputRow extends StatelessWidget {
  const _PriceInputRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final double value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            Text(
              '\$${value.round()}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Property Item ──────────────────────────────────────────────────
class _PropertyItem extends StatelessWidget {
  const _PropertyItem({
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
                child: Image.file(
                  listing.image,
                  fit: BoxFit.cover,
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
                    ListingPrice(
                      property: listing.property,
                      textSize: 20,
                    ),
                    const SizedBox(height: 6),
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
                    Row(
                      children: [
                        const Icon(
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

// ── Filter Item ────────────────────────────────────────────────────
class _FilterItem extends StatelessWidget {
  const _FilterItem({
    required this.icon,
    required this.filterType,
    required this.onPressed,
  });

  final IconData icon;
  final FilterType filterType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  filterType.name.translate(context, filterType.name).capitalize(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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

// ── Price Picker Dialog ────────────────────────────────────────────
class _PricePickerDialog extends StatefulWidget {
  const _PricePickerDialog({
    required this.initialPrice,
    required this.range,
  });

  final double initialPrice;
  final Range range;

  @override
  State<_PricePickerDialog> createState() => _PricePickerDialogState();
}

class _PricePickerDialogState extends State<_PricePickerDialog> {
  late double _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.initialPrice;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).selectPrice,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$${_selectedPrice.round()}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
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
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            AppLocalizations.of(context).cancel,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selectedPrice),
          child: Text(
            AppLocalizations.of(context).done,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
