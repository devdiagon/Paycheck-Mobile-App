import 'package:flutter/material.dart';

class TerracottaColors {
  static const Color orange = Color(0xFFED6745);
  static const Color cream = Color(0xFFF9F9E7);
  static const Color peach = Color(0xFFF9D6A4);
  static const Color darkCharcoal = Color(0xFF36302B);

  static const Color error = Color(0xFFBC3728);
  static const Color success = Color(0xFF7D9B76);
  static const Color info = Color(0xFF6A8EA0);
  static const Color warn = Color(0xFFE39E54);
}


class SaintColors {
  static const Color dark_blue = Color(0xFF3674B5);
  static const Color blue = Color(0xFF578FCA);
  static const Color light = Color(0xFFFAFCFF);
  static const Color black = Color(0xFFFADA7A);

  static const Color error = Color(0xFFF07D7D);
}

ColorScheme getColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    seedColor: SaintColors.dark_blue,
    brightness: brightness,
    primary: SaintColors.dark_blue,
    onPrimary: SaintColors.light,
    secondary: SaintColors.blue,
    onSecondary: TerracottaColors.darkCharcoal,
    surface: SaintColors.blue,
    onSurface: TerracottaColors.darkCharcoal,
    error: SaintColors.error,
    onError: Colors.white,
  );
}