import 'dart:async';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserSessionContextRepository {
  UserSessionContextRepository({required this.apiService});
  final ApiService apiService;
  Future<UserSessionContext?> getUserSessionContext({
    required String userId,
  }) async {
    final endpoint = '/userSessionContext/$userId';

    try {
      // ignore: inference_failure_on_function_invocation
      final response = await apiService.getRequest<UserSessionContext>(
        endpoint,
        UserSessionContext.fromJson,
      );

      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch user session context data');
      rethrow;
    }
  }
}
