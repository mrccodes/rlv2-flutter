// lib/models/api_response.dart

class ApiResponse<T> {
  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
  });
  // Helper method to create a success response
  factory ApiResponse.success(
    T data,
    String message,
    int statusCode,
  ) {
    return ApiResponse(
      data: data,
      statusCode: statusCode,
      message: message,
    );
  }

  // Helper method to create an error response
  factory ApiResponse.error(
    String message,
    int statusCode,
    List<String>? errors,
  ) {
    return ApiResponse(
      message: message,
      statusCode: statusCode,
      errors: errors,
    );
  }

  final int statusCode; // The HTTP status code
  final String message; // The message associated with the operation
  final List<String>? errors; // A list of errors on a failed response
  final T? data; // The data on a successful response
}
