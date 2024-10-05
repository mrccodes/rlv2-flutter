import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class AuthRepository {
  AuthRepository({required this.apiService});
  final ApiService apiService;

  Future<User> login({required String email, required String password}) async {
    final apiUrl = apiService.apiUrl;
    const endpoint = '/login';
    AppLogger.info('Attempting to login at $apiUrl$endpoint');

    try {
      // ignore: inference_failure_on_function_invocation
      final response = await apiService.postRequest<User>(
          endpoint, {'email': email, 'password': password}, User.fromJson);

      return response.data!;
    } catch (e) {
      AppLogger.error('Error logging in: $e');
      throw Exception('Failed to login: $e');
    }
  }

  // Add other authentication methods like logout, register if needed
  Future<User> logout() async {
    const endpoint = '/logout';
    final response = await apiService.getRequest(endpoint, User.fromJson);

    if (response.statusCode == 200) {
      return response.data!;
    } else {
      throw Exception('Failed to login');
    }
  }
}
