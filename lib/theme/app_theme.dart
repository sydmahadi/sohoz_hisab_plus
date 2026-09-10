import 'package:flutter/material.dart';

class AppTheme {
  // ─────────────────────────────────────────────
  // Islamic Light Color Palette
  // ─────────────────────────────────────────────

  static const Color primary = Color(0xFF176B45);
  static const Color primaryDark = Color(0xFF0D5134);
  static const Color primaryLight = Color(0xFF2D8A5F);

  static const Color background = Color(0xFFF6F3EA);
  static const Color backgroundSecondary = Color(0xFFECE8DC);

  static const Color cardColor = Color(0xFFFFFEFA);
  static const Color cardLight = Color(0xFFF4F0E5);

  static const Color gold = Color(0xFFB28A3E);
  static const Color goldLight = Color(0xFFD6B96A);

  static const Color textDark = Color(0xFF17352A);
  static const Color textMuted = Color(0xFF68776F);

  static const Color danger = Color(0xFF9B3D35);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      secondary: gold,
      onSecondary: Colors.white,
      surface: cardColor,
      onSurface: textDark,
      error: danger,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: textDark,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),

    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),

      labelStyle: const TextStyle(
        color: textMuted,
        fontWeight: FontWeight.w500,
      ),

      hintStyle: const TextStyle(
        color: Color(0xFF9AA49E),
      ),

      prefixIconColor: primary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFD8D5CA),
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFD8D5CA),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: primary,
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFFD9D6CC),
      thickness: 1,
      space: 1,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w800,
      ),
      displayMedium: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: TextStyle(
        color: textDark,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(
        color: textDark,
      ),
      bodyMedium: TextStyle(
        color: textMuted,
      ),
      bodySmall: TextStyle(
        color: textMuted,
      ),
    ),
  );
}
