// lib/models/api_response.dart

class ApiResponse<T> {
  ApiResponse({
    required this.success,
    this.data,
    this.errorMessage,
  });
  // Helper method to create a success response
  factory ApiResponse.success(T data) {
    return ApiResponse(success: true, data: data);
  }

  // Helper method to create an error response
  factory ApiResponse.error(String errorMessage) {
    return ApiResponse(success: false, errorMessage: errorMessage);
  }
  final bool success;
  final T? data; // The data on a successful response
  final String? errorMessage; // The error message on a failure response


}