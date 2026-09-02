import 'package:flutter/material.dart';

class AppTheme {
  static const Color red = Color(0xFFB71C1C);
  static const Color redBright = Color(0xFFFF1744);
  static const Color black = Color(0xFF050505);
  static const Color surface = Color(0xFF151515);
  static const Color muted = Color(0xFF9E9E9E);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: black,
    primaryColor: redBright,
    colorScheme: const ColorScheme.dark(
      primary: redBright,
      secondary: red,
      surface: surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: redBright,
          width: 2,
        ),
      ),
    ),
  );
}
