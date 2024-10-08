import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class AuthRepository {
  AuthRepository({required this.apiService});
  final ApiService apiService;

  final endpoint = '/login';

  Future<User> login({required String email, required String password}) async {
    try {
      // ignore: inference_failure_on_function_invocation
      final response = await apiService.postRequest<User>(
        endpoint,
        {'email': email, 'password': password},
        User.fromJson,
      );

      return response;
    } catch (e) {
      handleError(e, 'Failed to login');
      rethrow;
    }
  }

  // Add other authentication methods like logout, register if needed
  Future<User> logout() async {
    try {
      final response = await apiService.getRequest(endpoint, User.fromJson);
      return response;
    } catch (e) {
      handleError(e, 'Failed to logout');
      rethrow;
    }
  }
}
