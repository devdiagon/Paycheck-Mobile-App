import 'package:flutter/material.dart';
import 'color_schema.dart';

TextTheme getTextTheme() {
  return const TextTheme(
    displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal), // Headline1
    displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal),
    displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal),
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal), // Headline4
    headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal),
    headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: TerracottaColors.darkCharcoal),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: TerracottaColors.darkCharcoal), // Subtitle1
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: TerracottaColors.darkCharcoal),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: TerracottaColors.darkCharcoal),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: TerracottaColors.darkCharcoal), // BodyText1
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: TerracottaColors.darkCharcoal), // BodyText2
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: TerracottaColors.darkCharcoal),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: TerracottaColors.darkCharcoal), // Button
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: TerracottaColors.darkCharcoal),
    labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: TerracottaColors.darkCharcoal),
  ).apply(
    fontFamily: 'Roboto',
    bodyColor: TerracottaColors.darkCharcoal,
    displayColor: TerracottaColors.darkCharcoal,
  );
}