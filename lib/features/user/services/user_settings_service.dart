import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';
import 'package:rlv2_flutter/features/user/repositories/user_settings_repository.dart';

class UserSettingsService {
  UserSettingsService({
    required this.userSettingsRepository,
  });

  final UserSettingsRepository userSettingsRepository;

  Future<UserSettings> fetchUserSettings(String userId) async {
    try {
      final userSettings =
          await userSettingsRepository.getUserSettings(userId: userId);
      return userSettings;
    } catch (e) {
      throw Exception('Error fetching user settings: $e');
    }
  }

  Future<UserSettings> updateUserSettings(
    String userId,
    UserSettings userSettings,
  ) async {
    try {
      await userSettingsRepository.updateUserSettings(
        userId: userId,
        userSettings: userSettings,
      );
      return userSettings;
    } catch (e) {
      throw Exception('Error updating user settings: $e');
    }
  }

  Future<UserSettings> createUserSettings(
    String userId,
    UserSettings userSettings,
  ) async {
    try {
      final response = await userSettingsRepository.createUserSettings(
        userId: userId,
        userSettings: userSettings,
      );
      return response;
    } catch (e) {
      throw Exception('Error creating user settings: $e');
    }
  }

  Future<UserSettings> deleteUserSettings(String userId) async {
    try {
      final response =
          await userSettingsRepository.deleteUserSettings(userId: userId);
      return response;
    } catch (e) {
      throw Exception('Error deleting user settings: $e');
    }
  }

  Future<UserSettings> patchUserSettings(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await userSettingsRepository.patchUserSettings(
        userId: userId,
        data: data,
      );
      return response;
    } catch (e) {
      throw Exception('Error patching user settings: $e');
    }
  }
}
