import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_color.dart';

class AppTheme {
  static const Color white = AppColors.white;
  static const Color mediumWhite = AppColors.mediumWhite;
  static const Color black = AppColors.black;
  static const Color lightBlack = AppColors.lightBlack;
  static const Color mediumBlack = AppColors.mediumBlack;
  static const Color darkBlack = AppColors.darkBlack;
  static const Color grey = AppColors.grey;
  static const Color brown = AppColors.brown;
  static const Color lightBrown = AppColors.lightBrown;
  static const Color yellow = AppColors.yellow;
  static const Color red = AppColors.red;
  static const Color transparent = AppColors.transparent;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: brown,
    hintColor: lightBrown,
    scaffoldBackgroundColor: white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: black),
      bodyMedium: TextStyle(color: mediumBlack),
    ),
    appBarTheme: const AppBarTheme(
      color: white,
      iconTheme: IconThemeData(
        color: white,
        size: 20,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(146, 255, 255, 255),
    hintColor: brown,
    scaffoldBackgroundColor: black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: white),
      bodyMedium: TextStyle(color: mediumWhite),
    ),
    appBarTheme: const AppBarTheme(
      color: lightBrown,
      iconTheme: IconThemeData(
        color: white,
        size: 20,
      ),
    ),
  );
}
