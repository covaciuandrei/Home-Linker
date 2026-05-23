import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homelinker/core/app_theme.dart';

/// Renders a listing's image, or a neutral placeholder when the image
/// could not be resolved. Centralized so every screen treats missing
/// images consistently.
class ListingImage extends StatelessWidget {
  const ListingImage({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    this.iconSize = 32,
  });

  final File? image;
  final BoxFit fit;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        color: AppColors.surface,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textTertiary,
          size: iconSize,
        ),
      );
    }
    return Image.file(image!, fit: fit);
  }
}
