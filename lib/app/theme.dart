import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Define your primary color (accent for buttons, appbars, etc.)
      primaryColor: const Color(0xFFBC5F04),

      // Secondary color used for widgets like FABs, text selection, etc.
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.white, // Primary color
        secondary: const Color(0xFF35302D), // Secondary color
        surface: const Color(0xFFF0E6DC), // Surface color (cards, modals)
        error: const Color.fromARGB(255, 167, 21, 21), // Error color
        onPrimary: const Color(0xFF140700), // Text/icons on primary color
        onSecondary: Colors.white, // Text/icons on secondary color
        onSurface: const Color(0xFF140700), // Text/icons on surfaces
        onError: Colors.white, // Text/icons on error
        brightness: Brightness.light, // Light theme
      ),

      // Background settings
      scaffoldBackgroundColor: const Color(0xFFF0E6DC), // Background color

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFF35302D),
        selectionColor: Color(0xFFBC5F04),
        selectionHandleColor: Color(0xFFBC5F04),
      ),
      inputDecorationTheme: InputDecorationTheme(
        
        focusedBorder: const  OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBC5F04),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF35302D),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF35302D),
          ),
        ),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: lightTheme.colorScheme.error);
          } 
          return TextStyle(color: lightTheme.colorScheme.secondary);
        }),
        labelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: lightTheme.colorScheme.error);
          }
          return TextStyle(color: lightTheme.colorScheme.secondary);
        }),
        hintStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: lightTheme.colorScheme.error);
          }
          return TextStyle(color: lightTheme.colorScheme.secondary);
        }),
        // set border to inverse primary when focused

      ),


      // App bar settings
      appBarTheme: const AppBarTheme(
        color: Color(0xFF140700), // Dark color for the AppBar
        iconTheme: IconThemeData(color: Color(0xFFBC5F04)), // Orange icons
        titleTextStyle: TextStyle(
          color: Colors.white, // White text for the AppBar title
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme:
            IconThemeData(color: Color(0xFFBC5F04)), // Orange action icons
      ),

      // Button settings
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFBC5F04),
        textTheme: ButtonTextTheme.accent,
      ),

      // Text styles
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Color(0xFF140700),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF140700),
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: Color(0xFF140700),
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: Color(0xFF140700), fontSize: 16),
        bodySmall: TextStyle(color: Color(0xFF140700), fontSize: 14),
        bodyLarge: TextStyle(color: Color(0xFF140700), fontSize: 18),
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

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFBC5F04),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Color(0xFF35302D),
        surface: Color(0xFF1E1E1E),
        error: Color.fromARGB(255, 167, 21, 21),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF1E1E1E),
        iconTheme: IconThemeData(color: Color(0xFFBC5F04)),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme: IconThemeData(color: Color(0xFFBC5F04)),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFBC5F04),
        textTheme: ButtonTextTheme.accent,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        bodySmall: TextStyle(color: Colors.white, fontSize: 14),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBC5F04),
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
