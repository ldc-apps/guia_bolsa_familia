import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle title = const TextStyle(
      color: AppColors.greenDark, fontSize: 24, fontWeight: FontWeight.w900);
  static TextStyle subtitle =
      const TextStyle(color: AppColors.greenDark, fontSize: 18);

  static ThemeData theme = ThemeData(
      primaryColor: const Color(0xFF008CFF),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.green, size: 32),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 24, color: AppColors.green, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontSize: 18, color: AppColors.green),
        bodyText1: TextStyle(fontSize: 18, color: AppColors.green),
        subtitle1: TextStyle(fontSize: 18, color: AppColors.green),
        button: TextStyle(fontSize: 18, color: AppColors.white),
      ));

  static TextTheme get text => Theme.of(contextGlobal).textTheme;

  static TextStyle get button =>
      Theme.of(contextGlobal).textTheme.button ??
      const TextStyle(fontSize: 18, color: AppColors.white);

  static List<BoxShadow> get shadow => [
        BoxShadow(
          color: AppColors.disable.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 3,
          offset: const Offset(0, 2.5),
        )
      ];

  static List<BoxShadow> get shadowBlack => [
        const BoxShadow(
          color: AppColors.black,
          spreadRadius: 0,
          blurRadius: 3,
          offset: Offset(0, 2.5),
        )
      ];

  static double appBarHeight = 54;
}
