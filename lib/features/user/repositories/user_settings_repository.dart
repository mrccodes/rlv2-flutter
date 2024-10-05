import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';

class UserSettingsRepository {
  UserSettingsRepository({required this.apiService});
  final ApiService apiService;

  Future<UserSettings> getUserSettings({required String userId}) async {
    final endpoint = '/userSettings/$userId';

    try {
      // ignore: inference_failure_on_function_invocation
      final response = await apiService.getRequest<UserSettings>(
        endpoint,
        UserSettings.fromJson,
      );

      return response.data!;
    } catch (e) {
      throw Exception('Failed to fetch user settings data: $e');
    }
  }
}
