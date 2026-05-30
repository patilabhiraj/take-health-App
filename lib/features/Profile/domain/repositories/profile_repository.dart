import '../entities/profile_update_data.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<UserProfile> updateProfile(ProfileUpdateData data);
  Future<String> uploadProfilePicture(String filePath);
}
