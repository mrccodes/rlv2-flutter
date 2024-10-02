// lib/models/api_response.dart

class ApiResponse<T> {
  ApiResponse({required this.data, required this.message});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'] as String,
    );
  }
  final T? data;
  final String message;
}
