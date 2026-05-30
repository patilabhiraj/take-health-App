import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';
import '../../domain/usecases/upload_profile_picture_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getProfile;
  final UpdateUserProfileUseCase _updateProfile;
  final UploadProfilePictureUseCase _uploadPicture;

  ProfileBloc(
    this._getProfile,
    this._updateProfile,
    this._uploadPicture,
  ) : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileRefreshRequested>(_onRefresh);
    on<ProfileUpdateRequested>(_onUpdate);
    on<ProfilePictureUploadRequested>(_onUploadPicture);
  }

  Future<void> _onLoad(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) return;
    emit(ProfileLoading());
    try {
      final profile = await _getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onRefresh(
    ProfileRefreshRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await _getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final current = state is ProfileLoaded ? (state as ProfileLoaded).profile : null;
    emit(ProfileSaving(current));
    try {
      final updated = await _updateProfile(event.data);
      emit(ProfileLoaded(updated, saveSuccess: true));
    } catch (e) {
      emit(ProfileLoaded(current!, saveError: e.toString()));
    }
  }

  Future<void> _onUploadPicture(
    ProfilePictureUploadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final current = state is ProfileLoaded ? (state as ProfileLoaded).profile : null;
    emit(ProfileSaving(current));
    try {
      await _uploadPicture(event.filePath);
      // Refresh full profile to get updated picture URL
      final updated = await _getProfile();
      emit(ProfileLoaded(updated, saveSuccess: true));
    } catch (e) {
      if (current != null) {
        emit(ProfileLoaded(current, saveError: e.toString()));
      } else {
        emit(ProfileError(e.toString()));
      }
    }
  }
}
