import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      if (userModel.token.isNotEmpty) {
        await localDataSource.saveToken(userModel.token);
      }
      return Right(userModel);
    } on EmailVerificationRequiredException catch (e) {
      try {
        await remoteDataSource.resendEmailOtp(e.email);
      } catch (_) {}
      return Left(EmailVerificationFailure(e.email, e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to login.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    try {
      final userModel = await remoteDataSource.register(
        firstName,
        lastName,
        email,
        password,
        phoneNumber: phoneNumber,
      );
      if (userModel.token.isNotEmpty) {
        await localDataSource.saveToken(userModel.token);
      }
      return Right(userModel);
    } on EmailVerificationRequiredException catch (e) {
      return Left(EmailVerificationFailure(e.email, e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to register.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleLogin(String token) async {
    try {
      final userModel = await remoteDataSource.googleLogin(token);
      if (userModel.token.isNotEmpty) {
        await localDataSource.saveToken(userModel.token);
      }
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to send OTP.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(email, otp, newPassword);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to reset password.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmailOtp(String email, String otp) async {
    try {
      final userModel = await remoteDataSource.verifyEmailOtp(email, otp);
      // Save token after successful OTP verification
      if (userModel.token.isNotEmpty) {
        await localDataSource.saveToken(userModel.token);
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to verify OTP.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> resendEmailOtp(String email) async {
    try {
      await remoteDataSource.resendEmailOtp(email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_dioMessage(e, 'Failed to resend OTP.')));
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null || token.isEmpty) return const Right(null);

      final parts = token.split('.');
      if (parts.length != 3) {
        await localDataSource.deleteToken();
        return const Right(null);
      }

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final map = json.decode(payload) as Map<String, dynamic>;

      final user = UserModel(
        id: (map['id'] ?? map['sub'] ?? '').toString(),
        email: map['email'] ?? '',
        firstName: map['firstName'] ?? map['given_name'] ?? 'User',
        lastName: map['lastName'] ?? map['family_name'] ?? '',
        token: token,
      );

      return Right(user);
    } catch (e) {
      return const Left(ServerFailure('Failed to load local session.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Call backend logout endpoint first
      try {
        await remoteDataSource.logout();
      } catch (_) {
        // Continue with local logout even if backend call fails
      }
      // Delete local token
      await localDataSource.deleteToken();
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to logout.'));
    }
  }

  String _dioMessage(DioException e, String fallback) {
    // Try to extract error message from various response formats
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        // Check common error message fields
        return data['message'] ?? 
               data['error'] ?? 
               data['msg'] ?? 
               fallback;
      } else if (data is String) {
        return data;
      }
    } catch (_) {
      // Ignore parsing errors
    }
    
    // Return DioException type message or fallback
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet.';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'Connection error. Please check your internet.';
    }
    
    return fallback;
  }
}
