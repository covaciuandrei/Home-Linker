import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:homelinker/models/property.dart';

class Listing extends Equatable {
  const Listing({
    required this.image,
    required this.property,
  });

  final File image;
  final Property property;

  @override
  List<Object?> get props => [image, property];
}
