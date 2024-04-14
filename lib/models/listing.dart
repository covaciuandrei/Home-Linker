import 'dart:io';

import 'package:homelinker/models/property.dart';

class Listing {
  Listing({
    required this.image,
    required this.property,
  });
  final File image;
  final Property property;
}
