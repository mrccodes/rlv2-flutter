import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ApiService {
  ApiService({String? baseUrl, String? version}) {
    // Use environment variables or fallback to defaults
    this.baseUrl = baseUrl ?? dotenv.env['API_URL'] ?? 'http://172.27.7.89:3000';
    this.version = version ?? dotenv.env['API_VERSION'] ?? 'v1';
    
    // Make sure you're correctly concatenating baseUrl and version
    apiUrl = '${this.baseUrl}/${this.version}';  // Properly concatenate
    _setupDio();
  }

  late String baseUrl;
  late String version;
  final Dio dio = Dio();
  late final String apiUrl;

  void _setupDio() {
    dio.options.baseUrl = apiUrl;  // Ensure the correct baseUrl is set
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.info('Sending request to ${options.baseUrl}${options.path}');
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
}
