import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF2A1070),
    onPrimary: Colors.white,
    secondary: const Color(0xFF5F6A7D),
    onSecondary: Colors.white,
    error: const Color(0xFFD32F2F),
    onError: Colors.white,
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF1C1C1E),
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F6F8),
  primaryColor: const Color(0xFF2A1070),
  cardColor: const Color(0xFFFFFFFF),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF2A1070),
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF1C1C1E),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF1C1C1E),
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF1C1C1E),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      color: const Color(0xFF5C5C5C),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      color: const Color(0xFF5C5C5C),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2A1070),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF5A4FCF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF2A1070), width: 2),
    ),
    labelStyle: GoogleFonts.inter(color: const Color(0xFF5C5C5C)),
  ),
);

class AppTheme {
  static const Color primaryColor = Color(0xFF4A4A8B);
  static const Color surfaceColor = Color(0xFFF5F5F5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: surfaceColor,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const primary = Color(0xFF2A1070);
  static const accent = Color(0xFF5A4FCF);
  static const secondary = Color(0xFF5F6A7D);
  static const success = Color(0xFF2E7D32);
  static const error = Color(0xFFD32F2F);
  static const warning = Color(0xFFFFA000);
  static const info = Color(0xFF7986CB);
  static const background = Color(0xFFF4F6F8);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF5C5C5C);
}
