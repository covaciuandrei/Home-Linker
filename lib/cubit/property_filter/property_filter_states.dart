part of 'package:homelinker/cubit/property_filter/property_filter_cubit.dart';

class PropertyFilterState extends BaseState {
  const PropertyFilterState({
    this.propertyType,
    this.listingType,
    this.priceRange,
    this.bounds = const RangeValues(0, 1000000),
  });

  final PropertyType? propertyType;
  final ListingType? listingType;

  /// User-selected price range; `null` means "no price filter applied".
  final RangeValues? priceRange;

  /// Min/max price across the underlying dataset — used to seed slider limits.
  final RangeValues bounds;

  PropertyFilterState copyWith({
    ValueGetter<PropertyType?>? propertyType,
    ValueGetter<ListingType?>? listingType,
    ValueGetter<RangeValues?>? priceRange,
    RangeValues? bounds,
  }) {
    return PropertyFilterState(
      propertyType: propertyType != null ? propertyType() : this.propertyType,
      listingType: listingType != null ? listingType() : this.listingType,
      priceRange: priceRange != null ? priceRange() : this.priceRange,
      bounds: bounds ?? this.bounds,
    );
  }

  @override
  List<Object?> get props => [propertyType, listingType, priceRange, bounds];
}
