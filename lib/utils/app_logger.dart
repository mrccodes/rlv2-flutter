import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  // Info level log
  static void info(String message) {
    _logger.i(message);
  }

  // Warning level log
  static void warning(String message) {
    _logger.w(message);
  }

  // Error level log with optional exception
  static void error(String message, [Exception? e, StackTrace? s]) {
    _logger.e(message, error: e, stackTrace: s);
  }

  // Debug level log
  static void debug(String message) {
    _logger.d(message);
  }

  // Verbose level log (for detailed logs)
  static void trace(String message) {
    _logger.t(message);
  }
}
