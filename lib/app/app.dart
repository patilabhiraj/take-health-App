import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/theme.dart';
import '../core/utils/app_logger.dart';
import '../features/Auth/bloc/auth_bloc.dart';
import '../features/Auth/bloc/splash_bloc.dart';
import '../features/Auth/bloc/forgot_password_bloc.dart';
import 'injection.dart';
import 'routes/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SplashBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ForgotPasswordBloc>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                logger.info('🚪 User logged out - navigating to splash');
                AppRouter.router.go(AppRouter.splash);
              }
            },
            child: MaterialApp.router(
              title: 'Take Health',
              debugShowCheckedModeBanner: false,

              // ── Theme ─────────────────────────────────────────────────────────────
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,

              // ── GoRouter ──────────────────────────────────────────────────────────
              routerConfig: AppRouter.router,
            ),
          );
        },
      ),
    );
  }
}
