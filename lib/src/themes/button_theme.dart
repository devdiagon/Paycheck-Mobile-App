import 'package:flutter/material.dart';
import 'color_schema.dart';

ElevatedButtonThemeData getElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: SaintColors.light,
      backgroundColor: SaintColors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0, // Subtle elevation
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

OutlinedButtonThemeData getOutlinedButtonTheme() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: SaintColors.blue,
      side: const BorderSide(color: SaintColors.blue, width: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

TextButtonThemeData getTextButtonTheme() {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: SaintColors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}