import '../entities/profile_update_data.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository _repository;
  UpdateUserProfileUseCase(this._repository);

  Future<UserProfile> call(ProfileUpdateData data) =>
      _repository.updateProfile(data);
}
