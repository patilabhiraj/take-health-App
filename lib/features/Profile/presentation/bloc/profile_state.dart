import '../../domain/entities/user_profile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSaving extends ProfileState {
  final UserProfile? current;
  ProfileSaving(this.current);
}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  final bool saveSuccess;
  final String? saveError;

  ProfileLoaded(
    this.profile, {
    this.saveSuccess = false,
    this.saveError,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
