import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../core/network/api_client.dart';
import '../core/theme/theme_cubit.dart';
import '../features/Auth/bloc/auth_bloc.dart';
import '../features/Auth/bloc/forgot_password_bloc.dart';
import '../features/Auth/bloc/splash_bloc.dart';
import '../features/Auth/data/datasources/auth_local_data_source.dart';
import '../features/Auth/data/datasources/auth_remote_data_source.dart';
import '../features/Auth/data/repositories/auth_repository_impl.dart';
import '../features/Auth/domain/repositories/auth_repository.dart';
import '../features/Auth/domain/usecases/forgot_password_usecase.dart';
import '../features/Auth/domain/usecases/get_cached_user_usecase.dart';
import '../features/Auth/domain/usecases/google_login_usecase.dart';
import '../features/Auth/domain/usecases/login_usecase.dart';
import '../features/Auth/domain/usecases/logout_usecase.dart';
import '../features/Auth/domain/usecases/register_usecase.dart';
import '../features/Auth/domain/usecases/resend_email_otp_usecase.dart';
import '../features/Auth/domain/usecases/reset_password_usecase.dart';
import '../features/Auth/domain/usecases/verify_email_otp_usecase.dart';

final sl = GetIt.instance;

void init() {
  // ── Core & External ───────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => ThemeCubit());

  // ── Data Sources ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // ── Repositories ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // ── Use Cases ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendEmailOtpUseCase(sl()));

  // ── BLoCs ─────────────────────────────────────────────────────────────────────
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ForgotPasswordBloc(sl(), sl()));
}
