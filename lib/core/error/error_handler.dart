import 'package:dio/dio.dart';
import '../utils/app_logger.dart';

class ErrorHandler {
  static String handleError(dynamic error, [StackTrace? stackTrace]) {
    String userMessage = 'Something went wrong. Please try again.';

    if (error is DioException) {
      userMessage = _handleDioError(error);
      logger.error('API Error: ${error.message}', error, stackTrace);
    } else if (error is FormatException) {
      userMessage = 'Invalid data format';
      logger.error('Format Error: ${error.message}', error, stackTrace);
    } else if (error is TypeError) {
      userMessage = 'Data processing error';
      logger.error('Type Error: ${error.toString()}', error, stackTrace);
    } else {
      logger.error('Unknown Error: ${error.toString()}', error, stackTrace);
    }

    return userMessage;
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Server error. Please try again.';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access denied';
      case 404:
        return 'Data not found';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try later.';
      default:
        return 'Something went wrong (Code: $statusCode)';
    }
  }

  static void logError(String context, dynamic error, [StackTrace? stackTrace]) {
    logger.error('[$context] Error occurred', error, stackTrace);
  }

  static void logWarning(String message, [dynamic data]) =>
      logger.warning(message, data);

  static void logInfo(String message, [dynamic data]) =>
      logger.info(message, data);
}
