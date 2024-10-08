import 'package:flutter/material.dart';

class MyAppTheme {
  static const primaryColor = Color(0xFFBC5F04);
  static const primaryGrey = Color(0xFF35302D);
  static const primarySwatch = MaterialColor(
    0xFFBC5F04,
    <int, Color>{
      50: Color(0xFFFFEEE2),
      100: Color(0xFFF8DEC9),
      200: Color(0xFFE9BE98),
      300: Color(0xFFDA9F67),
      400: Color(0xFFCB7F35),
      500: Color(0xFFBC5F04),
      600: Color(0xFF924903),
      700: Color(0xFF683302),
      800: Color(0xFF3E1D01),
      900: Color(0xFF140700),
    },
  );

  static ThemeData get lightTheme {
    return ThemeData(
      // Define your primary color (accent for buttons, appbars, etc.)
      primaryColor: primaryColor,
      primarySwatch: primarySwatch,

      // Secondary color used for widgets like FABs, text selection, etc.
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.white, // Primary color
        secondary: primaryGrey, // Secondary color
        surface: primarySwatch.shade50, // Surface color (cards, modals)
        error: const Color.fromARGB(255, 167, 21, 21), // Error color
        onPrimary: primarySwatch.shade900, // Text/icons on primary color
        onSecondary: Colors.white, // Text/icons on secondary color
        onSurface: primarySwatch.shade900, // Text/icons on surfaces
        onError: Colors.white, // Text/icons on error
        brightness: Brightness.light, // Light theme
      ),

      // Background settings
      scaffoldBackgroundColor: primarySwatch.shade50, // Background color

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primarySwatch.shade500,
        selectionColor: primarySwatch.shade500,
        selectionHandleColor: primarySwatch.shade500,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primarySwatch.shade500,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryGrey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryGrey,
          ),
        ),
        floatingLabelStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
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
      appBarTheme: AppBarTheme(
        color: primarySwatch.shade900, // Dark color for the AppBar
        iconTheme: IconThemeData(color: primarySwatch.shade50), // Orange icons
        titleTextStyle: const TextStyle(
          color: Colors.white, // White text for the AppBar title
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme:
            IconThemeData(color: primarySwatch.shade500), // Orange action icons
      ),

      // Button settings
      buttonTheme: ButtonThemeData(
        buttonColor: primarySwatch.shade500,
        textTheme: ButtonTextTheme.accent,
      ),

      // Text styles
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          color: primarySwatch.shade900,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: primarySwatch.shade900,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: primarySwatch.shade900,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: primarySwatch.shade900, fontSize: 16),
        bodySmall: TextStyle(color: primarySwatch.shade900, fontSize: 14),
        bodyLarge: TextStyle(color: primarySwatch.shade900, fontSize: 18),
      ),

      // Elevated button style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primarySwatch.shade500, // Button background color
          textStyle: const TextStyle(color: Colors.white), // Button text color
        ),
      ),

      // Icon themes
      iconTheme: IconThemeData(color: primarySwatch.shade900),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primarySwatch.shade500,
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
      appBarTheme: AppBarTheme(
        color: const Color(0xFF1E1E1E),
        iconTheme: IconThemeData(color: primarySwatch.shade500),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme: IconThemeData(color: primarySwatch.shade500),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primarySwatch.shade500,
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
          backgroundColor: primarySwatch.shade500,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
