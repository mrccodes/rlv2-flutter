import 'package:dio/dio.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class UserSessionContextService extends ApiService {
  Future<UserSessionContext> getUserSessionContext({
    required String userId,
  }) async {
    final endpoint = '/userSessionContext/$userId';

    AppLogger.info('Attempting API request at $apiUrl$endpoint');

    try {
      // ignore: inference_failure_on_function_invocation
      final response = await dio.get(
        endpoint,
      );

      AppLogger.info('Response Status: ${response.statusCode}');
      AppLogger.info('Response Data: ${response.data}');

      final responseData = response.data;

      // Ensure that responseData is a Map
      // final userContext = validateResponseData<UserSessionContext>(responseData);
      final userContext = responseData['data'];

      AppLogger.info('UserSessionContext: $userContext');

      return UserSessionContext.fromJson(userContext as Map<String, dynamic>);
    } on DioException catch (e) {
      // Handle Dio-specific errors...
      if (e.response != null) {
        AppLogger.error('Dio Error: ${e.response!.statusCode}');
        AppLogger.error('Dio Error: ${e.response!.data}');
        if (e.response!.statusCode == 401) {
          throw Exception('Invalid email or password');
        }
        if (e.response!.statusCode == 404) {
          throw Exception('Email does not exist');
        }
        if (e.response!.statusCode == 400) {
          // ignore: avoid_dynamic_calls
          if (e.response!.data != null && e.response!.data['message'] != null) {
            // ignore: avoid_dynamic_calls
            throw Exception(e.response!.data['message']);
          }
          // ignore: avoid_dynamic_calls
          throw Exception(e.response!.data['message']);
        }
        throw Exception('Failed to login: ${e.response!.data}');
      } else {
        throw Exception('Failed to login (e.response): $e');
      }
    } catch (e) {
      AppLogger.error(e.toString());
      throw Exception('Failed to login: $e');
    }
  }
}
