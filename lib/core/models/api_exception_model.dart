class ApiException implements Exception {
  ApiException({
    required this.statusCode,
    required this.message,
    this.errors = const [],
  });

  final int statusCode;
  final String message;
  final List<String> errors;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
