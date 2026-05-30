import '../repositories/profile_repository.dart';

class UploadProfilePictureUseCase {
  final ProfileRepository _repository;
  UploadProfilePictureUseCase(this._repository);

  Future<String> call(String filePath) =>
      _repository.uploadProfilePicture(filePath);
}
