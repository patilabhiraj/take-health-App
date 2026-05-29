import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackBar.showError(context, state.message);
          } else if (state is AuthAuthenticated) {
            context.go(AppRouter.home);
          } else if (state is AuthEmailVerificationRequired) {
            CustomSnackBar.showInfo(
              context,
              'Please verify your email. OTP sent to ${state.email}',
            );
            context.go(
              '${AppRouter.emailVerification}?email=${Uri.encodeComponent(state.email)}',
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // ── Logo ────────────────────────────────────────────────────
                  const Center(child: AuthLogo(dark: true)),
                  const SizedBox(height: 48),

                  // ── Title ───────────────────────────────────────────────────
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'LOGIN TO YOUR ACCOUNT',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // ── Email ───────────────────────────────────────────────────
                  AuthTextField(
                    label: 'Email Address',
                    hint: 'you@example.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.mail_outline_rounded,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ────────────────────────────────────────────────
                  AuthTextField(
                    label: 'Password',
                    hint: '••••••••',
                    isPassword: true,
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline_rounded,
                  ),
                  const SizedBox(height: 12),

                  // ── Remember me + Forgot password ───────────────────────────
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (v) =>
                              setState(() => _rememberMe = v ?? false),
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'REMEMBER ME',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.push(AppRouter.forgotPassword),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'FORGOT PASSWORD?',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── Sign In button ──────────────────────────────────────────
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : GradientButton(
                          label: 'Sign In',
                          icon: Icons.arrow_forward_rounded,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                email: _emailCtrl.text.trim().toLowerCase(),
                                password: _passwordCtrl.text,
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 32),

                  // ── Create Account link ─────────────────────────────────────
                  Center(
                    child: TextButton(
                      onPressed: () => context.go(AppRouter.register),
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
