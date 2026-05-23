import 'package:flutter/material.dart';
import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/listing_data.dart';
import 'package:homelinker/models/property.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/property_filter/property_filter_states.dart';

/// Owns filter selections (property type, listing type, selected price range)
/// for any list-of-properties screen. Filtering itself is a pure derivation
/// over the source list provided by the page; the cubit does not own the
/// listings — keeping responsibilities split from [HomeCubit].
@injectable
class PropertyFilterCubit extends BaseCubit {
  PropertyFilterCubit() : super(const PropertyFilterState());

  PropertyFilterState get _state => state as PropertyFilterState;

  /// Called by the page once the listings + bounds are known so the slider
  /// defaults can be initialised. Does not change the active selection.
  void initBounds(RangeValues bounds) {
    if (_state.bounds == bounds) return;
    safeEmit(_state.copyWith(bounds: bounds));
  }

  void setPropertyType(PropertyType? value) {
    safeEmit(_state.copyWith(propertyType: () => value));
  }

  void setListingType(ListingType? value) {
    safeEmit(_state.copyWith(listingType: () => value));
  }

  void setPriceRange(RangeValues? value) {
    safeEmit(_state.copyWith(priceRange: () => value));
  }

  void apply({
    required PropertyType? propertyType,
    required ListingType? listingType,
    required RangeValues? priceRange,
  }) {
    safeEmit(_state.copyWith(
      propertyType: () => propertyType,
      listingType: () => listingType,
      priceRange: () => priceRange,
    ));
  }

  void clearAll() {
    safeEmit(_state.copyWith(
      propertyType: () => null,
      listingType: () => null,
      priceRange: () => null,
    ));
  }
}

extension PropertyFilterApplication on PropertyFilterState {
  /// Pure projection of the active filter onto a source listing list.
  List<ListingData> applyTo(List<ListingData> source) {
    return source.where((element) {
      final property = element.listing.property;
      if (propertyType != null && property.propertyType != propertyType) {
        return false;
      }
      if (listingType != null && property.listingType != listingType) {
        return false;
      }
      if (priceRange != null && (property.price < priceRange!.start || property.price > priceRange!.end)) {
        return false;
      }
      return true;
    }).toList();
  }

  bool get isFiltered => propertyType != null || listingType != null || priceRange != null;
}
