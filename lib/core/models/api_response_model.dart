class ApiResponse<T> {
  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

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

  final int statusCode; // The HTTP status code
  final String message; // The message associated with the operation
  final T? data; // The data on a successful response
}
