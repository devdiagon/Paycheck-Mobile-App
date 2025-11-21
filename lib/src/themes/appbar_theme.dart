import 'package:flutter/material.dart';
import 'color_schema.dart';

AppBarTheme getAppBarTheme() {
  return const AppBarTheme(
    backgroundColor: SaintColors.dark_blue,
    foregroundColor: SaintColors.light,
    elevation: 4.0,
    scrolledUnderElevation: 8.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: SaintColors.light,
    ),
    iconTheme: IconThemeData(
      color: SaintColors.light,
      size: 24.0,
    ),
    actionsIconTheme: IconThemeData(
      color: SaintColors.light,
      size: 24.0,
    ),
  );
}