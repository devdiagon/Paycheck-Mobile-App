import 'package:flutter/material.dart';
import 'color_palettes.dart';

class SaintColors {
  static const Color primary = SkyColors.darkBlue;
  static const Color secondary = SkyColors.blue;
  static const Color background = SkyColors.light;
  static const Color foreground = SkyColors.light;
  static const Color surface = TerracottaColors.cream;
  static const Color contrast = TerracottaColors.darkCharcoal;

  static const Color error = SkyColors.error;
}

ColorScheme getColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    seedColor: SaintColors.primary,
    brightness: brightness,
    primary: SaintColors.primary,
    onPrimary: SaintColors.background,
    secondary: SaintColors.secondary,
    onSecondary: SaintColors.contrast,
    surface: SaintColors.secondary,
    onSurface: SaintColors.contrast,
    error: SaintColors.error,
    onError: Colors.white,
  );
}