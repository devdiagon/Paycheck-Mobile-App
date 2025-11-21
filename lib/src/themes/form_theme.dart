import 'package:flutter/material.dart';
import 'color_schema.dart';

InputDecorationTheme getInputDecorationTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: TerracottaColors.darkCharcoal, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: TerracottaColors.darkCharcoal, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: TerracottaColors.darkCharcoal, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: TerracottaColors.error, width: 3.0),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    labelStyle: const TextStyle(
      color: TerracottaColors.darkCharcoal,
      fontSize: 14.0,
    ),
    hintStyle: TextStyle(
      color: TerracottaColors.darkCharcoal.withValues(alpha: 0.5),
      fontSize: 14.0,
    ),
  );
}