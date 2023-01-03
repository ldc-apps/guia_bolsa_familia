import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static final ThemeData theme = ThemeData(
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.light(
        primary: AppColors.greenLight,
      ));

  static final List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 6,
      offset: const Offset(0, 0),
    ),
  ];

  static final List<BoxShadow> shadowLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 6,
      offset: const Offset(0, 0),
    ),
  ];
}
