import 'package:flutter/material.dart';

import 'appbar_theme.dart';
import 'background_theme.dart';
import 'button_theme.dart';
import 'color_schema.dart';
import 'form_theme.dart';
import 'typography_theme.dart';

ThemeData getGeneralTheme(Brightness brightness) {
  final colorScheme = getColorScheme(brightness);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: getBackgroundColor(),
    appBarTheme: getAppBarTheme(),
    elevatedButtonTheme: getElevatedButtonTheme(),
    outlinedButtonTheme: getOutlinedButtonTheme(),
    textButtonTheme: getTextButtonTheme(),
    inputDecorationTheme: getInputDecorationTheme(),
    textTheme: getTextTheme(),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    ),
    dividerTheme: const DividerThemeData(
      color: TerracottaColors.darkCharcoal,
      thickness: 1.0,
      space: 16.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.surface,
      contentTextStyle: const TextStyle(color: TerracottaColors.darkCharcoal),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
    ),
  );
}