import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackBar.showError(context, state.message);
          } else if (state is AuthAuthenticated) {
            CustomSnackBar.showSuccess(context, 'Account created successfully');
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
                  const SizedBox(height: 8),

                  // ── Logo ────────────────────────────────────────────────────
                  const Center(child: AuthLogo(dark: true)),
                  const SizedBox(height: 36),

                  // ── Title ───────────────────────────────────────────────────
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'START YOUR HEALTH JOURNEY',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Full Name ───────────────────────────────────────────────
                  AuthTextField(
                    label: 'Full Name *',
                    hint: 'Full Name',
                    controller: _firstNameCtrl,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 16),

                  // ── Email ───────────────────────────────────────────────────
                  AuthTextField(
                    label: 'Email Address *',
                    hint: 'you@example.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.mail_outline_rounded,
                  ),
                  const SizedBox(height: 16),

                  // ── Phone ───────────────────────────────────────────────────
                  AuthTextField(
                    label: 'Phone Number *',
                    hint: 'Phone Number',
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ────────────────────────────────────────────────
                  AuthTextField(
                    label: 'Password *',
                    hint: '••••••••',
                    isPassword: true,
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline_rounded,
                  ),
                  const SizedBox(height: 28),

                  // ── Continue button ─────────────────────────────────────────
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : GradientButton(
                          label: 'Continue',
                          icon: Icons.arrow_forward_rounded,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            // Split full name into first/last
                            final nameParts = _firstNameCtrl.text.trim().split(' ');
                            final firstName = nameParts.first;
                            final lastName = nameParts.length > 1
                                ? nameParts.sublist(1).join(' ')
                                : '';

                            context.read<AuthBloc>().add(
                              AuthRegisterRequested(
                                firstName: firstName,
                                lastName: lastName,
                                email: _emailCtrl.text.trim().toLowerCase(),
                                password: _passwordCtrl.text,
                                phoneNumber: _phoneCtrl.text.trim().isEmpty
                                    ? null
                                    : _phoneCtrl.text.trim(),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 28),

                  // ── Sign In link ────────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ALREADY REGISTERED? ',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRouter.login),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
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
