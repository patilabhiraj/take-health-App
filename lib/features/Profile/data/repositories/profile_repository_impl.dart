import 'package:take_health/features/Profile/domain/entities/profile_update_data.dart';
import 'package:take_health/features/Profile/domain/entities/user_profile.dart';
import 'package:take_health/features/Profile/domain/repositories/profile_repository.dart';
import 'package:take_health/features/Profile/data/datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remote;

  ProfileRepositoryImpl(this._remote);

  @override
  Future<UserProfile> getUserProfile() => _remote.getUserProfile();

  @override
  Future<UserProfile> updateProfile(ProfileUpdateData data) =>
      _remote.updateProfile(data);

  @override
  Future<String> uploadProfilePicture(String filePath) =>
      _remote.uploadProfilePicture(filePath);
}
