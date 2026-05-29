/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException({required String message}) : super(message);
}

class CacheException extends AppException {
  const CacheException({required String message}) : super(message);
}

class NetworkException extends AppException {
  const NetworkException({required String message}) : super(message);
}

class AuthException extends AppException {
  const AuthException({required String message}) : super(message);
}

class EmailVerificationRequiredException extends AppException {
  final String email;
  const EmailVerificationRequiredException({
    required this.email,
    required String message,
  }) : super(message);
}
