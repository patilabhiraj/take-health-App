import 'package:dio/dio.dart';
import 'package:take_health/core/constants/api_constants.dart';
import 'package:take_health/core/network/api_client.dart';
import 'package:take_health/features/Profile/domain/entities/profile_update_data.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateProfile(ProfileUpdateData data);
  Future<String> uploadProfilePicture(String filePath);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserProfileModel> getUserProfile() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.profile);
      return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load profile');
    }
  }

  @override
  Future<UserProfileModel> updateProfile(ProfileUpdateData data) async {
    try {
      final response = await _apiClient.dio.put(
        ApiConstants.updateProfile,
        data: data.toJson(),
      );
      return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to update profile');
    }
  }

  @override
  Future<String> uploadProfilePicture(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });
      final response = await _apiClient.dio.post(
        ApiConstants.uploadProfilePic,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final data = response.data as Map<String, dynamic>;
      return data['profilePicture'] as String? ?? '';
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to upload picture');
    }
  }
}
