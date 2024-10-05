import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/models/api_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ApiService {
  ApiService({String? baseUrl, String? version}) {
    // Use environment variables or fallback to defaults
    this.baseUrl =
        baseUrl ?? dotenv.env['API_URL'] ?? 'http://172.27.7.89:3000';
    this.version = version ?? dotenv.env['API_VERSION'] ?? 'v1';
    storage = const FlutterSecureStorage();
    // Make sure you're correctly concatenating baseUrl and version
    apiUrl = '${this.baseUrl}/${this.version}'; // Properly concatenate
    _setupDio();
  }

  late String baseUrl;
  late String version;
  final Dio dio = Dio();
  late FlutterSecureStorage storage;
  late final String apiUrl;

  void _setupDio() {
    dio.options.baseUrl = apiUrl; // Ensure the correct baseUrl is set
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    dio.options.extra['withCredentials'] = true;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          AppLogger.info(
            'Sending request to ${options.baseUrl}${options.path}',
          );
          // Retrieve the token from secure storage
          final authToken = await storage.read(key: 'auth_token');

          if (authToken != null) {
            // Add the token to the Authorization header
            options.headers['Authorization'] = 'Bearer $authToken';
          }

          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          AppLogger.info('Received response: ${response.statusCode}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioException e, handler) {
          AppLogger.error('Request failed: ${e.message}');
          return handler.next(e); // Continue with error handling
        },
      ),
    );
  }

  Future<Response<Map<String, dynamic>>> _handleSetCookie(
    Response<Map<String, dynamic>> response,
  ) async {
    final cookies = response.headers['set-cookie'];
    if (cookies != null && cookies.isNotEmpty) {
      // Assuming your token is prefixed by 'Authorization='
      final cookieString = cookies[0];
      final token = RegExp(
        'Authorization=([^;]+)',
      ).firstMatch(cookieString)?.group(1);

      if (token != null) {
        // Store just the token securely
        await storage.write(key: 'auth_token', value: token);
      }
    }
    return response; // Make sure to return the response here
  }

  Future<ApiResponse<T>> _handleRequest<T>(
    Future<Response<Map<String, dynamic>>> Function() requestFunc,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await requestFunc();

      final responseData = response.data!;

      if (response.statusCode == 200) {
        final data = fromJson(responseData['data'] as Map<String, dynamic>);
        return ApiResponse.success(
          data,
          responseData['message'] as String,
          response.statusCode!,
        );
      } else {
        return ApiResponse.error(
          responseData['message'] as String,
          response.statusCode!,
          responseData['errors'] != null
              ? List<String>.from(responseData['errors'] as List<dynamic>)
              : [],
        );
      }
    } catch (e) {
      return ApiResponse.error(
        'Exception: $e',
        500,
        ['An unknown error occurred'],
      );
    }
  }

  Future<ApiResponse<T>> getRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    return _handleRequest(
      () => dio.get<Map<String, dynamic>>(endpoint),
      fromJson,
    );
  }

  Future<ApiResponse<T>> postRequest<T>(
    String endpoint,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (endpoint == '/login') {
      return _handleRequest(
        () => dio
            .post<Map<String, dynamic>>(
              endpoint,
              data: data,
            )
            .then(_handleSetCookie),
        fromJson,
      );
    } else {
      return _handleRequest(
        () => dio.post<Map<String, dynamic>>(
          endpoint,
          data: data,
        ),
        fromJson,
      );
    }
  }
}
