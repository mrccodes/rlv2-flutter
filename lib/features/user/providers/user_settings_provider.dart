import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_settings_service.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class UserSettingsState {
  UserSettingsState({
    this.userSettings,
    this.isLoading = false,
    this.error,
  });
  final UserSettings? userSettings;
  final bool isLoading;
  final String? error;
  UserSettingsState Function() initial = UserSettingsState.new;

  @override
  String toString() {
    return 'UserSettingsState('
        'userSettings: $userSettings, '
        'isLoading: $isLoading, error: $error)';
  }

  UserSettingsState copyWith({
    UserSettings? userSettings,
    bool? isLoading,
    String? error,
  }) {
    return UserSettingsState(
      userSettings: userSettings ?? this.userSettings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Updated to accept initial data
final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, UserSettingsState>((ref) {
  return UserSettingsNotifier(
    ref.watch(userSettingsServiceProvider),
  );
});

class UserSettingsNotifier extends StateNotifier<UserSettingsState> {
  UserSettingsNotifier(this._userSettingsService) : super(UserSettingsState());
  final UserSettingsService _userSettingsService;

  // Accept initial data in the constructor

  Future<void> updateUserSettings(
      String userId, 
      UserSettings updatedSettings,
      ) async {
    try {
      final newSettings = await _userSettingsService.updateUserSettings(
        userId,
        updatedSettings,
      );
      state = UserSettingsState(userSettings: newSettings);
    } catch (e) {
      // Handle errors as needed
      AppLogger.error('Error updating settings: $e');
    }
  }
}
