import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_settings_service.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ThemeState {
  ThemeState({this.isLoading = false, this.error});
  final ThemeMode mode = ThemeMode.system;
  final bool isLoading;
  final String? error;

  ThemeState copyWith({
    ThemeMode? mode,
    bool? isLoading,
    String? error,
  }) {
    return ThemeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) {
    final userSettingsService = ref.watch(userSettingsServiceProvider);
    return ThemeNotifier(
      userSettingsService: userSettingsService,
      ref: ref,
    );
  },
);

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier({
    required this.userSettingsService,
    required this.ref,
  }) : super(ThemeState());

  final UserSettingsService userSettingsService;
  final Ref ref;

  void toggleThemeLocal(ThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  Future<void> toggleTheme(String userId, ThemeMode mode) async {
    try {
      state = ThemeState(isLoading: true);
      final userSettings = ref.read(userSettingsProvider);

      if (userSettings.data != null) {
        await ref.read(userSettingsProvider.notifier).patchUserSettings(
              userId,
              {'preferredMode': mode.name},
            );
      }

      state = state.copyWith(
        isLoading: false,
        mode: mode,
      );
    } catch (e) {
      AppLogger.error('Error updating theme: $e');
      if (mounted) {
        state = ThemeState(error: e.toString());
      }
    }
  }
}
