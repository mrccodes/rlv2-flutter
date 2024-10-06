import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

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

      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch user settings data');
      rethrow;
    }
  }

  Future<UserSettings> updateUserSettings({
    required String userId,
    required UserSettings userSettings,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      final response = await apiService.putRequest<UserSettings>(
        endpoint,
        userSettings.toJson(),
        UserSettings.fromJson,
      );

      return response;
    } catch (e) {
      handleError(e, 'Failed to update user settings data');
      rethrow;
    }
  }

  Future<UserSettings> createUserSettings({
    required String userId,
    required UserSettings userSettings,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      final response = await apiService.postRequest<UserSettings>(
        endpoint,
        userSettings.toJson(),
        UserSettings.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to create user settings data');
      rethrow;
    }
  }

  Future<UserSettings> deleteUserSettings({required String userId}) async {
    final endpoint = '/users/$userId/settings';

    try {
      final response = await apiService.deleteRequest<UserSettings>(
        endpoint,
        UserSettings.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete user settings data');
      rethrow;
    }
  }

  Future<UserSettings> patchUserSettings({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final endpoint = '/users/$userId/settings';

    try {
      final response = await apiService.patchRequest<UserSettings>(
        endpoint,
        data,
        UserSettings.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to patch user settings data');
      rethrow;
    }
  }
}
