import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette from specification
  static const Color spicyRed = Color(0xFFE63946);
  static const Color citrusOrange = Color(0xFFF77F00);
  static const Color cornYellow = Color(0xFFFDC500);
  static const Color offWhite = Color(0xFFF8F8F8);
  static const Color lightGrey = Color(0xFFEFEFEF);
  static const Color charcoal = Color(0xFF333333);
  static const Color avocadoGreen = Color(0xFF2A9D8F);
  static const Color white = Colors.white;
  static const Color cream = Color(0xFFFFFDD0);
  static const Color maizeYellow = Color(
    0xFFF4A460,
  ); // Approximating maize yellow

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: spicyRed,
      secondary: citrusOrange,
      tertiary: cornYellow,
      surface: offWhite,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: charcoal,
    ),
    fontFamily: 'Open Sans',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 2.5 * 16,
        color: charcoal,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 2.0 * 16,
        color: charcoal,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 1.5 * 16,
        color: charcoal,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: charcoal),
      bodyMedium: TextStyle(fontSize: 14, color: charcoal),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: charcoal,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: charcoal,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.zero,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: spicyRed,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGrey),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
    ),
  );
}
