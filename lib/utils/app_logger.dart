import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static Logger? _logger;

  static Logger _getLoggerInstance() {
    if (_logger == null) {
      return Logger();
    }
    return _logger!;
  }

  static Logger loggerInstance = _getLoggerInstance();

  /// For info logs
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    loggerInstance.i(
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// For debug logs
  static void d(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    loggerInstance.d(
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// For error logs
  static void e(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    loggerInstance.e(
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
