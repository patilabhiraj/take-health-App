import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:take_health/features/home/presentation/main_screen.dart';

import '../../core/utils/app_logger.dart';
import '../../features/Auth/bloc/auth_bloc.dart';
import '../../features/Auth/bloc/forgot_password_bloc.dart';
import '../../features/Auth/presentation/email_verification_page.dart';
import '../../features/Auth/presentation/forgot_password_page.dart';
import '../../features/Auth/presentation/login_page.dart';
import '../../features/Auth/presentation/register_page.dart';
import '../../features/Auth/presentation/splash_page.dart';
import '../injection.dart' show sl;

class AppRouter {
  static const String splash           = '/';
  static const String login            = '/login';
  static const String register         = '/register';
  static const String forgotPassword   = '/forgot-password';
  static const String emailVerification = '/email-verification';
  static const String home             = '/home';

  static late final GoRouter router;

  static void init(String initialLocation) {
    logger.info('🗺️ Initializing GoRouter with route: "$initialLocation"');
    router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: login,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const RegisterPage(),
          ),
        ),
        GoRoute(
          path: forgotPassword,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<ForgotPasswordBloc>(),
            child: const ForgotPasswordPage(),
          ),
        ),
        GoRoute(
          path: emailVerification,
          builder: (context, state) {
            final email = state.uri.queryParameters['email'] ?? '';
            return EmailVerificationPage(email: email);
          },
        ),
        GoRoute(
          path: home,
          builder: (context, state) => BlocProvider.value(
            value: sl<AuthBloc>(),
            child: const MainScreen(),
          ),
        ),
      ],
    );
  }
}
