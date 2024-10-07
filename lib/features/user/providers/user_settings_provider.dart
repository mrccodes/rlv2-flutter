import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_settings_service.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class UserSettingsState {
  UserSettingsState({
    this.data,
    this.isLoading = false,
    this.error,
  });
  final UserSettings? data;
  final bool isLoading;
  final String? error;
  UserSettingsState Function() initial = UserSettingsState.new;

  @override
  String toString() {
    return 'UserSettingsState('
        'userSettings: $data, '
        'isLoading: $isLoading, error: $error)';
  }

  UserSettingsState copyWith({
    UserSettings? data,
    bool? isLoading,
    String? error,
  }) {
    return UserSettingsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, UserSettingsState>((ref) {
  return UserSettingsNotifier(
    ref.watch(userSettingsServiceProvider),
  );
});

class UserSettingsNotifier extends StateNotifier<UserSettingsState> {
  UserSettingsNotifier(this._userSettingsService) : super(UserSettingsState());
  final UserSettingsService _userSettingsService;

  bool get isLoading => state.isLoading == true;
  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> loadUserSettings(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final userSettings = await _userSettingsService.fetchUserSettings(userId);
      state = state.copyWith(data: userSettings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> createUserSettings(
    String userId,
    UserSettings userSettings,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      await _userSettingsService.createUserSettings(
        userId,
        userSettings,
      );
      state = UserSettingsState(data: userSettings);
    } catch (e) {
      // Handle errors as needed
      AppLogger.error('Error creating settings: $e');
    }
  }

  Future<UserSettings> patchUserSettings(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      final userSettings = await _userSettingsService.patchUserSettings(
        userId,
        data,
      );
      state = UserSettingsState(data: userSettings);
      return userSettings;
    } catch (e) {
      // Handle errors as needed
      AppLogger.error('Error patching settings: $e');
      rethrow;
    }
  }

  Future<void> updateUserSettings(
    String userId,
    UserSettings updatedSettings,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      final newSettings = await _userSettingsService.updateUserSettings(
        userId,
        updatedSettings,
      );
      state = UserSettingsState(data: newSettings);
    } catch (e) {
      // Handle errors as needed
      AppLogger.error('Error updating settings: $e');
    }
  }

  void updateUserSettingsLocal(UserSettings userSettings) {
    state = state.copyWith(data: userSettings);
  }

  void clearUserSettings() {
    state = UserSettingsState();
  }
}
