import 'dart:convert';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
    String firstName,
    String lastName,
    String email,
    String password, {
    String? phoneNumber,
  });
  Future<UserModel> googleLogin(String token);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String email, String otp, String newPassword);
  Future<UserModel> verifyEmailOtp(String email, String otp);
  Future<void> resendEmailOtp(String email);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );

    // Backend returns: { success: true, token: "...", user: {...} }
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> register(
    String firstName,
    String lastName,
    String email,
    String password, {
    String? phoneNumber,
  }) async {
    // Step 1: Register user (returns OTP requirement)
    final response = await apiClient.dio.post(
      ApiConstants.register,
      data: {
        'name': '$firstName $lastName',
        'email': email,
        'password': password,
        'phone': phoneNumber,
      },
    );

    // Backend returns: { success: true, message: "OTP sent to email" }
    // Throw exception to trigger OTP verification flow
    throw EmailVerificationRequiredException(
      email: email,
      message: response.data['message'] ?? 'Please verify your email with OTP',
    );
  }

  @override
  Future<UserModel> googleLogin(String token) async {
    return _userFromJwt(token);
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Send password reset code to email
    await apiClient.dio.post(
      ApiConstants.forgotPassword,
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword(String email, String otp, String newPassword) async {
    // Step 1: Verify reset code
    await apiClient.dio.post(
      ApiConstants.verifyResetCode,
      data: {'email': email, 'code': otp},
    );

    // Step 2: Set new password
    await apiClient.dio.post(
      ApiConstants.resetPassword,
      data: {'email': email, 'newPassword': newPassword},
    );
  }

  @override
  Future<UserModel> verifyEmailOtp(String email, String otp) async {
    // Verify registration OTP and complete registration
    final response = await apiClient.dio.post(
      ApiConstants.registerOtp,
      data: {'email': email, 'otp': otp},
    );

    // Backend returns: { success: true, token: "...", user: {...} }
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> resendEmailOtp(String email) async {
    // Resend OTP by calling register again with same email
    await apiClient.dio.post(
      ApiConstants.register,
      data: {'email': email},
    );
  }

  @override
  Future<void> logout() async {
    // Call backend logout endpoint
    await apiClient.dio.post(ApiConstants.logout);
  }

  // ── helpers ──────────────────────────────────────────────────────────────────
  UserModel _userFromJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw const FormatException('Invalid JWT');
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final map = json.decode(payload) as Map<String, dynamic>;
    return UserModel(
      id: (map['id'] ?? map['sub'] ?? '').toString(),
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? map['given_name'] ?? 'Google',
      lastName: map['lastName'] ?? map['family_name'] ?? 'User',
      token: token,
    );
  }
}
