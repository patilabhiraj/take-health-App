import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../core/network/api_client.dart';
import '../core/theme/theme_cubit.dart';
// ── Auth ──────────────────────────────────────────────────────────────────────
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
// ── Profile ───────────────────────────────────────────────────────────────────
import '../features/Profile/data/datasources/profile_remote_data_source.dart';
import '../features/Profile/data/repositories/profile_repository_impl.dart';
import '../features/Profile/domain/repositories/profile_repository.dart';
import '../features/Profile/domain/usecases/get_user_profile_usecase.dart';
import '../features/Profile/domain/usecases/update_user_profile_usecase.dart';
import '../features/Profile/domain/usecases/upload_profile_picture_usecase.dart';
import '../features/Profile/presentation/bloc/profile_bloc.dart';
// ── AI Chat ───────────────────────────────────────────────────────────────────
import '../features/ai_chat/data/datasources/ai_chat_remote_data_source.dart';
import '../features/ai_chat/data/repositories/ai_chat_repository_impl.dart';
import '../features/ai_chat/domain/repositories/ai_chat_repository.dart';
import '../features/ai_chat/domain/usecases/clear_chat_history_usecase.dart';
import '../features/ai_chat/domain/usecases/get_chat_history_usecase.dart';
import '../features/ai_chat/domain/usecases/save_chat_history_usecase.dart';
import '../features/ai_chat/domain/usecases/send_chat_message_usecase.dart';

final sl = GetIt.instance;

void init() {
  // ── Core & External ───────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => ThemeCubit());

  // ── Auth — Data Sources ───────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // ── Auth — Repositories ───────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // ── Auth — Use Cases ──────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendEmailOtpUseCase(sl()));

  // ── Profile — Data Sources ────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // ── Profile — Repositories ────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // ── Profile — Use Cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadProfilePictureUseCase(sl()));

  // ── Profile — BLoC (singleton so MainScreen + ProfilePage share state) ────────
  sl.registerLazySingleton(() => ProfileBloc(sl(), sl(), sl()));

  // ── AI Chat — Data Sources ────────────────────────────────────────────────────
  sl.registerLazySingleton<AiChatRemoteDataSource>(
    () => AiChatRemoteDataSourceImpl(sl()),
  );

  // ── AI Chat — Repositories ────────────────────────────────────────────────────
  sl.registerLazySingleton<AiChatRepository>(
    () => AiChatRepositoryImpl(sl()),
  );

  // ── AI Chat — Use Cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SendChatMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetChatHistoryUseCase(sl()));
  sl.registerLazySingleton(() => SaveChatHistoryUseCase(sl()));
  sl.registerLazySingleton(() => ClearChatHistoryUseCase(sl()));

  // ── BLoCs (factories — fresh instance per route) ──────────────────────────────
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ForgotPasswordBloc(sl(), sl()));
}
