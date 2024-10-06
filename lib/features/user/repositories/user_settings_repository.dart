import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';

class UserSettingsRepository {
  UserSettingsRepository({required this.apiService});
  final ApiService apiService;

  Future<UserSettings> getUserSettings({required String userId}) async {
    final endpoint = '/users/$userId/settings';

    try {
      final response = await apiService.getRequest<UserSettings>(
        endpoint,
        UserSettings.fromJson,
      );

      return response.data!;
    } catch (e) {
      throw Exception('Failed to fetch user settings data: $e');
    }
  }

  Future<void> updateUserSettings({
    required String userId,
    required UserSettings userSettings,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      await apiService.putRequest<UserSettings>(
        endpoint,
        userSettings.toJson(),
        UserSettings.fromJson,
      );
    } catch (e) {
      throw Exception('Failed to update user settings data: $e');
    }
  }

  Future<void> createUserSettings({
    required String userId,
    required UserSettings userSettings,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      await apiService.postRequest<UserSettings>(
        endpoint,
        userSettings.toJson(),
        UserSettings.fromJson,
      );
    } catch (e) {
      throw Exception('Failed to create user settings data: $e');
    }
  }

  Future<void> deleteUserSettings({required String userId}) async {
    final endpoint = '/users/$userId/settings';

    try {
      await apiService.deleteRequest<UserSettings>(
        endpoint,
        UserSettings.fromJson,
      );
    } catch (e) {
      throw Exception('Failed to delete user settings data: $e');
    }
  }

  Future<void> patchUserSettings({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      await apiService.patchRequest<UserSettings>(
        endpoint,
        data,
        UserSettings.fromJson,
      );
    } catch (e) {
      throw Exception('Failed to patch user settings data: $e');
    }
  }
}
