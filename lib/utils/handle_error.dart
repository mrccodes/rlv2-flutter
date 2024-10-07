import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

void handleError(Object e, String? message) {
  AppLogger.error('Error occured \n$message: $e');
  if (e is ApiException) {
    throw e; // Rethrow specific ApiException
  } else {
    throw ApiException(
      statusCode: 500,
      message: message ?? 'Unexpected error occurred',
      errors: [e.toString()],
    );
  }
}
