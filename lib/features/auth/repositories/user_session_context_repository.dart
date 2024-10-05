

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class UserSessionContextService extends ApiService {
  Future<UserSessionContext?> getUserSessionContext({
    required String userId,
  }) async {
    final endpoint = '/userSessionContext/$userId';

    try {
      final response = await getRequest<UserSessionContext>(
        endpoint,
        UserSessionContext.fromJson,
      );

      final responseStr = response;
      AppLogger.info('getRequest respone: $responseStr');

      if (response.data == null) {
        throw Exception(response.message);
      }

      final userSessionContext = response.data!;
      AppLogger.info('userSessionContext: $userSessionContext');
      return response.data;
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
