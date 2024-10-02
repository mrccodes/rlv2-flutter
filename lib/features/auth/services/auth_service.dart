import 'package:dio/dio.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class AuthService {
  AuthService({this.baseUrl = 'http://172.27.7.89:3000', this.version = 'v1'}) {
    apiUrl = '$baseUrl/$version';
  }

  final String baseUrl;
  final String version;
  final Dio dio = Dio();
  late final String apiUrl;

  Future<User> login({required String email, required String password}) async {
    final endpoint = '$apiUrl/login';
    AppLogger.info('Attempting to login at $apiUrl$endpoint');

    try {
      // ignore: inference_failure_on_function_invocation
      final response = await dio.post(
        endpoint,
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      AppLogger.info('Response Status: ${response.statusCode}');
      AppLogger.info('Response Data: ${response.data}');

      final responseData = response.data;

      // Ensure that responseData is a Map
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic>) {
          final userData = responseData['data'];

          return User.fromJson(userData as Map<String, dynamic>);
        } else {
          throw Exception('User data is null or not in expected format.');
        }
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
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

  // Add other authentication methods like logout, register if needed
  Future<User> logout() async {
    final response = await dio.post<User>(
      '$apiUrl/logout',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromJson(response.data! as Map<String, String>);
    } else {
      throw Exception('Failed to login');
    }
  }
}
