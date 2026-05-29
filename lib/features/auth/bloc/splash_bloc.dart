import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_health/features/auth/domain/usecases/get_cached_user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCachedUserUseCase _getCachedUserUseCase;

  SplashBloc(this._getCachedUserUseCase) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    // Minimum splash display duration
    await Future.delayed(const Duration(milliseconds: 2000));

    final result = await _getCachedUserUseCase();

    result.fold(
      (failure) => emit(SplashLoaded()),
      (user) {
        if (user != null) {
          emit(SplashNavigateToHome());
        } else {
          emit(SplashLoaded());
        }
      },
    );
  }
}
