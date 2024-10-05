import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  ThemeState({this.isLoading = false, this.error});
  final bool isLoading;
  final String? error;
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState());

  Future<void> toggleTheme(ThemeMode mode) async {
    try {
      state = ThemeState(isLoading: true);

      state = ThemeState();
    } catch (e) {
      state = ThemeState(error: e.toString());
    }
  }
}
