import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_settings_service.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ThemeState {
  ThemeState({this.isLoading = false, this.error});
  final bool isLoading;
  final String? error;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) {
    final userSettingsService = ref.watch(userSettingsServiceProvider);
    final userSettings = ref.watch(userSettingsProvider);
    return ThemeNotifier(
      userSettingsService: userSettingsService,
      userSettings: userSettings,
      ref: ref,
    );
  },
);

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier({
    required this.userSettingsService,
    required this.userSettings,
    required this.ref,
  }) : super(ThemeState());

  final UserSettingsService userSettingsService;
  final UserSettingsState userSettings;
  final Ref ref;

  Future<void> toggleTheme(String userId, ThemeMode mode) async {
    try {
      state = ThemeState(isLoading: true);

      // Call the userSettingsService to patch the settings
      await userSettingsService.patchUserSettings(userId, {
        'preferredMode': mode.name,
      });


      await ref.read(userSettingsProvider.notifier).updateUserSettings(
            userId,
            userSettings.userSettings!.copyWith(preferredMode: mode.name),
      );


      // End loading state
      state = ThemeState();
    } catch (e) {
      AppLogger.error('Error updating theme: $e');
      if (mounted) {
        state = ThemeState(error: e.toString());
      }
    }
  }
}
