import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/listing/listing_cubit.dart';
import 'package:homelinker/models/listing.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/models/user.dart';
import 'package:homelinker/presentation/widgets/app_toast.dart';
import 'package:homelinker/presentation/widgets/back_arrow_button.dart';
import 'package:homelinker/presentation/widgets/listing_price.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/utils/extension_methods.dart';

@RoutePage()
class ListingPage extends StatefulWidget implements AutoRouteWrapper {
  const ListingPage({
    super.key,
    required this.listing,
    required this.user,
    this.isSaved = false,
  });

  final Listing listing;
  final User user;
  final bool isSaved;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ListingCubit>(
      create: (_) => getIt<ListingCubit>(),
      child: this,
    );
  }

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listing = widget.listing;
    final user = widget.user;

    return BlocConsumer<ListingCubit, BaseState>(
      listener: (context, state) {
        if (state is ListingDeletedState) {
          BlocProvider.of<HomeCubit>(context).refresh();
          AutoRouter.of(context).popForced();
        } else if (state is ListingFavoritedState) {
          setState(() => _isSaved = true);
          AppToast.show(
            context,
            message: AppLocalizations.of(context).listingAddedToFavorites,
            icon: Icons.favorite_rounded,
            accentColor: AppColors.success,
          );
        } else if (state is ListingUnfavoritedState) {
          setState(() => _isSaved = false);
          AppToast.show(
            context,
            message: AppLocalizations.of(context).listingRemovedFromFavorites,
            icon: Icons.favorite_border_rounded,
            accentColor: AppColors.textSecondary,
          );
        } else if (state is SomethingWentWrongState) {
          AppToast.show(
            context,
            message: AppLocalizations.of(context).somethingWrong,
            icon: Icons.error_outline_rounded,
            accentColor: AppColors.error,
          );
        }
      },
      builder: (context, state) {
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            backgroundColor: AppColors.surface,
            extendBody: true,
            body: Stack(
              children: [
                // ── Hero Image ────────────────────────────────
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Hero(
                    tag: 'property_${listing.property.id}',
                    child: Image.file(
                      listing.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // ── Gradient overlay on image ────────────────
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.1),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                // ── Back Button ──────────────────────────────
                SafeArea(child: const BackArrowButton()),

                // ── Content Sheet ────────────────────────────
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              // ── Handle bar ────────────────
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.divider,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),

                              // ── Header Info ───────────────
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listing.property.propertyType.name
                                                .translate(context, listing.property.propertyType.name)
                                                .capitalize(),
                                            style: theme.textTheme.headlineSmall?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 16,
                                                color: AppColors.textTertiary,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  listing.property.location,
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    color: AppColors.textSecondary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${AppLocalizations.of(context).listedBy} ${listing.property.ownerName}',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: AppColors.textTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ListingPrice(
                                          property: listing.property,
                                          textSize: 24,
                                        ),
                                        const SizedBox(height: 8),
                                        Material(
                                          color: _isSaved
                                              ? AppColors.error.withValues(alpha: 0.10)
                                              : AppColors.primary.withValues(alpha: 0.08),
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            customBorder: const CircleBorder(),
                                            onTap: () {
                                              if (_isSaved) {
                                                BlocProvider.of<ListingCubit>(context)
                                                    .removeFavorite(id: listing.property.id);
                                              } else {
                                                BlocProvider.of<ListingCubit>(context)
                                                    .addFavorite(id: listing.property.id);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: AnimatedSwitcher(
                                                duration: const Duration(milliseconds: 250),
                                                child: Icon(
                                                  _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                                  key: ValueKey<bool>(_isSaved),
                                                  color: _isSaved ? AppColors.error : AppColors.primary,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // ── Selling Points ────────────
                              PropertySellingPointLine(
                                property: listing.property,
                                icons: const [
                                  Icons.calendar_month_outlined,
                                  Icons.real_estate_agent_outlined,
                                  Icons.landscape_outlined,
                                ],
                                isFirstLine: true,
                              ),
                              PropertySellingPointLine(
                                property: listing.property,
                                icons: const [
                                  Icons.bathroom_outlined,
                                  Icons.bed_outlined,
                                  Icons.local_parking_outlined,
                                ],
                                isFirstLine: false,
                              ),

                              // ── Description ───────────────
                              PropertyDescription(
                                description: listing.property.description,
                              ),
                              const SizedBox(height: 20),

                              // ── Delete Button ─────────────
                              if (listing.property.ownerEmail == user.email)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MainButton(
                                    isDestructive: true,
                                    width: 220,
                                    text: AppLocalizations.of(context).deleteListing,
                                    icon: Icons.delete_outline_rounded,
                                    onPressed: () {
                                      _confirmDelete(context);
                                    },
                                  ),
                                ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => Padding(
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
            const SizedBox(height: 24),
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).deleteListing,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    isOutlined: true,
                    text: AppLocalizations.of(context).cancel,
                    onPressed: () => Navigator.of(bottomSheetContext).pop(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MainButton(
                    isDestructive: true,
                    text: AppLocalizations.of(context).deleteListing,
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                      BlocProvider.of<ListingCubit>(context).deleteListing(property: widget.listing.property);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Property Description ───────────────────────────────────────────
class PropertyDescription extends StatelessWidget {
  const PropertyDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).description,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Property Selling Point Line ────────────────────────────────────
class PropertySellingPointLine extends StatelessWidget {
  const PropertySellingPointLine({
    super.key,
    required this.property,
    required this.icons,
    required this.isFirstLine,
  });

  final Property property;
  final List<IconData> icons;
  final bool isFirstLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          PropertySellingPoint(
            icon: icons[0],
            text: isFirstLine
                ? '${AppLocalizations.of(context).year} ${property.constructionYear}'
                : '${property.bathrooms} ${property.bathrooms == 1 ? AppLocalizations.of(context).bathroom : AppLocalizations.of(context).bathrooms}',
          ),
          PropertySellingPoint(
            icon: icons[1],
            text: isFirstLine
                ? '${AppLocalizations.of(context).perntru} ${property.listingType.name}'
                : '${property.bedrooms} ${property.bedrooms == 1 ? AppLocalizations.of(context).bedroom : AppLocalizations.of(context).bedrooms}',
          ),
          PropertySellingPoint(
            icon: icons[2],
            text: isFirstLine
                ? '${AppLocalizations.of(context).size} ${property.areaSize} ${AppLocalizations.of(context).squareMeters}'
                : '${property.parkingSpaces} ${property.parkingSpaces == 1 ? AppLocalizations.of(context).parkingSpace : AppLocalizations.of(context).parkingSpace}',
          ),
        ],
      ),
    );
  }
}

// ── Property Selling Point ─────────────────────────────────────────
class PropertySellingPoint extends StatelessWidget {
  const PropertySellingPoint({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
