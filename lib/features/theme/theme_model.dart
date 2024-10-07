import 'package:flutter/material.dart';

class ThemeModeModel {
  ThemeModeModel({required this.mode});
  final ThemeMode mode;

  // Add convenience methods if necessary
  static ThemeMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
