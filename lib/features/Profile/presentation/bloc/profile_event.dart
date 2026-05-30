import '../../domain/entities/profile_update_data.dart';

abstract class ProfileEvent {}

class ProfileLoadRequested extends ProfileEvent {}

class ProfileRefreshRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final ProfileUpdateData data;
  ProfileUpdateRequested(this.data);
}

class ProfilePictureUploadRequested extends ProfileEvent {
  final String filePath;
  ProfilePictureUploadRequested(this.filePath);
}
