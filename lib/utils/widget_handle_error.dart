import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

void widgetHandleError(
  Object error,
  BuildContext context,
  StackTrace? stackTrace,
) {
  void showError(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  if (error is ApiException) {
    showError(error.errors.join('\n'));
    AppLogger.error(error.toString(), error, stackTrace);
  } else if (error is Exception) {
    showError(error.toString());
    AppLogger.error(error.toString(), error, stackTrace);
  } else {
    showError('An unknown error occurred');
    AppLogger.error(error.toString());
  }
}
