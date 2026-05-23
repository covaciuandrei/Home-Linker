import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:homelinker/models/property.dart';

class Listing extends Equatable {
  const Listing({
    required this.image,
    required this.property,
  });

  /// Resolved image file for the listing. `null` when the image could not be
  /// fetched (missing in storage, no network, etc.) — the UI must show a
  /// placeholder in that case.
  final File? image;
  final Property property;

  @override
  List<Object?> get props => [image, property];
}
