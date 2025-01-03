import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData darkThemeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Color(0xFF424242),
      onSecondary: Colors.white70,
      surface: Color(0xFF303030),
      onSurface: Colors.white70,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.merriweatherTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(fontSize: 16, color: Colors.white),
        bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.grey,
  );
}
