import 'package:flutter/material.dart';

/// [Palette] stores the colors and color schemes used 
/// in the app.
class Palette {
  // The colors used in the app
  static const Color primary = Color(0xFFFF6F00);
  static const Color onPrimary = Colors.white;

  static const Color primaryContainer = Color(0xFFFF9C36);
  static const Color onPrimaryContainer = Colors.black;

  static const Color secondary = Colors.grey;
  static const Color onSecondary = Colors.black;

  static const Color secondaryContainer = Colors.grey;
  static const Color onSecondaryContainer = Colors.white;

  static const Color tertiary = Colors.black;
  static const Color onTertiary = Colors.white;

  static const Color tertiaryContainer = Color(0xFF424242);
  static const Color onTertiaryContainer = Colors.white;

  static const Color background = Color(0xFFF9F9F9);
  static const Color onBackground = Colors.black;

  static const Color error = Colors.redAccent;
  static const Color onError = Colors.white;

  static const Color outline = Colors.grey;

  // Light color scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    background: background,
    onBackground: onBackground,
    surface: background,
    onSurface: onBackground,
    error: Colors.red,
    onError: Colors.white,
    outline: outline,
    brightness: Brightness.light,
  );
}
