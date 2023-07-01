import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: independenceColor),
  scaffoldBackgroundColor: Colors.white,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: mainPinkColor,
    actionTextColor: mainWhiteColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: independenceColor,
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: independenceColor),
  scaffoldBackgroundColor: Colors.white,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: mainPinkColor,
    actionTextColor: mainWhiteColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: independenceColor,
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
  ),
);
