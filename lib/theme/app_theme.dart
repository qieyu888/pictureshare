import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray900 = Color(0xFF111827);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color orange500 = Color(0xFFF97316);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color yellow500 = Color(0xFFEAB308);
  static const Color red500 = Color(0xFFEF4444);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: black,
        secondary: gray700,
        surface: white,
      ),
      scaffoldBackgroundColor: white,
      fontFamily: null,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: gray900),
        titleTextStyle: TextStyle(
          color: gray900,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: gray900),
        bodyMedium: TextStyle(color: gray700),
        bodySmall: TextStyle(color: gray500),
      ),
    );
  }
}
