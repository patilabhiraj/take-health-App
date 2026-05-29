import 'package:logger/logger.dart';

/// Centralized logging service for Take Health app
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  late final Logger _logger;

  void init({bool isProduction = false}) {
    _logger = Logger(
      filter: isProduction ? ProductionFilter() : DevelopmentFilter(),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      output: isProduction ? ProductionOutput() : ConsoleOutput(),
    );
  }

  void debug(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  void info(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  void warning(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  void fatal(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}

class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => event.level.index >= Level.warning.index;
}

class ProductionOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // Production madhe crash reporting service la send karu (Firebase Crashlytics)
  }
}

/// Global logger instance
final logger = AppLogger();
