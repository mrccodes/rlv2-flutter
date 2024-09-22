import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData get theme {
    return ThemeData(
      // Define your primary color (accent for buttons, appbars, etc.)
      primaryColor: const Color(0xFFBC5F04),

      // Secondary color used for widgets like FABs, text selection, etc.
      colorScheme: const ColorScheme(
        primary: Color(0xFFBC5F04),  // Primary color
        secondary: Color(0xFF140700),  // Secondary color
        surface: Color(0xFFF0E6DC),  // Surface color (cards, modals)
        error: Colors.red,  // Error color
        onPrimary: Colors.white,  // Text/icons on primary color
        onSecondary: Colors.white,  // Text/icons on secondary color
        onSurface: Color(0xFF140700),  // Text/icons on surfaces
        onError: Colors.white,  // Text/icons on error
        brightness: Brightness.light,  // Light theme
      ),

      // Background settings
      scaffoldBackgroundColor: const Color(0xFFF0E6DC),

      // App bar settings
     appBarTheme: const AppBarTheme(
      color: Color(0xFF140700), // Dark color for the AppBar
      iconTheme: IconThemeData(color: Color(0xFFBC5F04)), // Orange icons
      titleTextStyle: TextStyle(
        color: Colors.white, // White text for the AppBar title
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: Color(0xFFBC5F04)), // Orange action icons
    ),

      // Button settings
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFBC5F04),
        textTheme: ButtonTextTheme.primary,
      ),
      
      // Floating Action Button (FAB) style
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF140700),
        foregroundColor: Colors.white,
      ),

      // Text styles
      textTheme: const TextTheme(
        headlineSmall: TextStyle(color: Color(0xFF140700), fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: Color(0xFF140700), fontSize: 32, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: Color(0xFF140700), fontSize: 40, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: Color(0xFF140700), fontSize: 16),
        bodySmall: TextStyle(color: Color(0xFF140700), fontSize: 14),
      ),

      // Elevated button style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBC5F04), // Button background color
          textStyle: const TextStyle(color: Colors.white), // Button text color
        ),
      ),

      // Icon themes
      iconTheme: const IconThemeData(color: Color(0xFF140700)),
    );
  }
}
