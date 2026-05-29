import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'app/injection.dart' as di;
import 'app/routes/router.dart';
import 'core/error/error_handler.dart';
import 'core/utils/app_logger.dart';
import 'features/Auth/domain/usecases/get_cached_user_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Initialize Logger ─────────────────────────────────────────────────────────
  const isProduction = bool.fromEnvironment('dart.vm.product');
  logger.init(isProduction: isProduction);
  logger.info('🚀 Take Health starting... (Production: $isProduction)');

  // ── Initialize Dependency Injection ──────────────────────────────────────────
  di.init();

  // ── Force portrait orientation ────────────────────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Status bar style ──────────────────────────────────────────────────────────
  // Colors will be adapted by the ThemeCubit / MaterialApp based on theme mode.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // ── Session Auto-Routing ──────────────────────────────────────────────────────
  String initialRoute = AppRouter.splash;

  try {
    final getCachedUser = di.sl<GetCachedUserUseCase>();
    final result = await getCachedUser();

    result.fold(
      (failure) {
        logger.warning('No cached session: ${failure.toString()}');
        initialRoute = AppRouter.splash;
      },
      (user) {
        if (user != null) {
          logger.info('✅ Active session found for ${user.email}. Routing to Home.');
          initialRoute = AppRouter.home;
        } else {
          logger.info('No cached user. Routing to Splash.');
          initialRoute = AppRouter.splash;
        }
      },
    );
  } catch (e, stackTrace) {
    ErrorHandler.logError('Session Check', e, stackTrace);
    initialRoute = AppRouter.splash;
  }

  // ── Initialize Router ─────────────────────────────────────────────────────────
  AppRouter.init(initialRoute);

  runApp(const App());
}
