import 'package:flutter/material.dart';
import 'color_schema.dart';

AppBarTheme getAppBarTheme() {
  return const AppBarTheme(
    backgroundColor: SaintColors.primary,
    foregroundColor: SaintColors.foreground,
    elevation: 4.0,
    scrolledUnderElevation: 8.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: SaintColors.foreground,
    ),
    iconTheme: IconThemeData(
      color: SaintColors.foreground,
      size: 24.0,
    ),
    actionsIconTheme: IconThemeData(
      color: SaintColors.foreground,
      size: 24.0,
    ),
  );
}