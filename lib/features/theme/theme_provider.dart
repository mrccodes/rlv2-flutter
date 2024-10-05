import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/theme/theme_model.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeModeType>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeModeType> {
  ThemeNotifier() : super(ThemeModeType.system); // Default to system

  set themeMode(ThemeModeType mode) {
    state = mode;
  }

  ThemeModeType get themeMode {
    return state;
  }

  bool isUsingSystemTheme() {
    return state == ThemeModeType.system;
  }
}
