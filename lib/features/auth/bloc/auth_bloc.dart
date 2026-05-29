import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/app_logger.dart';
import '../domain/entities/user_entity.dart';
import '../domain/usecases/google_login_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._googleLoginUseCase,
    this._logoutUseCase,
  ) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    logger.info('🔐 Login requested for: ${event.email}');

    final result = await _loginUseCase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) {
        if (failure is EmailVerificationFailure) {
          logger.warning('📧 Email verification required: ${failure.email}');
          emit(AuthEmailVerificationRequired(failure.email));
        } else {
          logger.error('❌ Login failed: ${failure.message}');
          emit(AuthError(failure.message));
        }
      },
      (user) {
        logger.info('✅ Login successful: ${user.email}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    logger.info('📝 Register requested for: ${event.email}');

    final result = await _registerUseCase(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) {
        if (failure is EmailVerificationFailure) {
          logger.info('📧 Email verification required after register: ${failure.email}');
          emit(AuthEmailVerificationRequired(failure.email));
        } else {
          logger.error('❌ Register failed: ${failure.message}');
          emit(AuthError(failure.message));
        }
      },
      (user) {
        logger.info('✅ Register successful: ${user.email}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    logger.info('🔑 Google sign-in requested');

    final result = await _googleLoginUseCase(event.token);

    result.fold(
      (failure) {
        logger.error('❌ Google sign-in failed: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {
        logger.info('✅ Google sign-in successful: ${user.email}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.info('🚪 Logout requested');
    await _logoutUseCase();
    emit(AuthInitial());
  }
}
