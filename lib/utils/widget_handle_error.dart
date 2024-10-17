import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

String widgetHandleError(
  Object error,
  BuildContext context, {
  bool notifyUser = false,
  StackTrace? stackTrace,
}) {
  String showError(String message) {
    if (context.mounted && notifyUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      });
    }
    return message;
  }

  if (error is ApiException) {
    AppLogger.error(error.toString(), error, stackTrace);

    return showError(error.errors.join('\n'));
  } else if (error is Exception) {
    AppLogger.error(error.toString(), error, stackTrace);
    return showError(error.toString());
  } else {
    AppLogger.error(error.toString());
    return showError('An unknown error occurred');
  }
}
