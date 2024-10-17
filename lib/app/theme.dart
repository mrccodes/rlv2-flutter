import 'package:flutter/material.dart';

class MyAppTheme {
  static const primaryColor = Color(0xFFBC5F04);
  static const primaryGrey = Color.fromARGB(255, 130, 125, 121);
  static const primarySwatch = MaterialColor(
    0xFFBC5F04,
    <int, Color>{
      50: Color(0xFFfaf4f0),
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

  static const textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodySmall: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 18),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontSize: 24,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
    ),
    displaySmall: TextStyle(
      fontSize: 16,
    ),
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
        tertiary: primaryGrey.withOpacity(.3), // Tertiary color
        surface: primarySwatch.shade50, // Surface color (cards, modals)
        error: const Color.fromARGB(255, 167, 21, 21), // Error color
        onPrimary: primarySwatch.shade900, // Text/icons on primary color
        onSecondary: Colors.white, // Text/icons on secondary color
        onTertiary: primarySwatch.shade900, // Text/icons on tertiary color
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
        filled: true, // Fills the background
        isDense: true,
        fillColor: Colors.grey.withOpacity(0.2), // Opaque light background
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // No border
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // No border when enabled
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // No border when focused
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 167, 21, 21)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 167, 21, 21)),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),

        hintStyle: TextStyle(
          color: primarySwatch.shade800,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(color: primarySwatch.shade900),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(
          color: primarySwatch.shade900,
          fontSize: 16,
        ),

        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),  // Very subtle shadow
        //     blurRadius: 10,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return primarySwatch.shade500;
            }
            return primarySwatch.shade500.withOpacity(.6);
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return primarySwatch.shade200;
            }
            return primarySwatch.shade100;
          },
        ),
      ),

      expansionTileTheme: ExpansionTileThemeData(
        iconColor: primarySwatch.shade900,
        textColor: primarySwatch.shade900,
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
      textTheme: textTheme,

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
      primaryColor: primaryColor,
      primarySwatch: primarySwatch,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Color(0xFF35302D),
        surface: Color(0xFF1E1E1E),
        error: Color.fromARGB(255, 167, 21, 21),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return primarySwatch.shade500;
            }
            return primarySwatch.shade500.withOpacity(.8);
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return primarySwatch.shade100;
            }
            return primarySwatch.shade50;
          },
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Fills the background
        isDense: true,

        fillColor: Colors.grey.withOpacity(0.1), // Opaque light background
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // No border
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // No border when enabled
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // No border when focused
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 167, 21, 21)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 167, 21, 21)),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        hintStyle: TextStyle(
          color: primarySwatch.shade50,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: const TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
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
      textTheme: textTheme,
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
