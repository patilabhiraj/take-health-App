import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/router.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/forgot_password_bloc.dart';
import 'widgets/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int _step = 0;
  String _email = '';
  String _otp = '';

  void _next() => setState(() => _step++);

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordOtpSent) {
          _next();
        } else if (state is ForgotPasswordSuccess) {
          setState(() => _step = 3);
        } else if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _step < 3
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: isLoading
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          onPressed: _back,
                        ),
                  title: Text(
                    'BACK',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  titleSpacing: 0,
                )
              : null,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_step < 3) ...[
                  const SizedBox(height: 6),
                  StepProgressIndicator(totalSteps: 3, currentStep: _step),
                  const SizedBox(height: 4),
                ],
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.06, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(parent: anim, curve: Curves.easeOut),
                        ),
                        child: child,
                      ),
                    ),
                    child: KeyedSubtree(
                      key: ValueKey(_step),
                      child: [
                        _EmailStep(
                          isLoading: isLoading,
                          onNext: (email) {
                            _email = email;
                            context
                                .read<ForgotPasswordBloc>()
                                .add(FPSendOtpRequested(email));
                          },
                        ),
                        _OtpStep(
                          email: _email,
                          isLoading: isLoading,
                          onNext: (otp) {
                            _otp = otp;
                            _next();
                          },
                          onChangeEmail: _back,
                        ),
                        _NewPasswordStep(
                          isLoading: isLoading,
                          onNext: (password) {
                            context.read<ForgotPasswordBloc>().add(
                              FPResetPasswordRequested(
                                email: _email,
                                otp: _otp,
                                newPassword: password,
                              ),
                            );
                          },
                        ),
                        _SuccessStep(
                          onSignIn: () => context.go(AppRouter.login),
                        ),
                      ][_step],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Step 1 – Email ────────────────────────────────────────────────────────────
class _EmailStep extends StatefulWidget {
  const _EmailStep({required this.isLoading, required this.onNext});
  final bool isLoading;
  final ValueChanged<String> onNext;

  @override
  State<_EmailStep> createState() => _EmailStepState();
}

class _EmailStepState extends State<_EmailStep> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),

          // Title
          const Text(
            'RESET ACCESS',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'STEP 1 OF 3 • EMAIL',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          AuthTextField(
            label: 'Email Address',
            hint: 'Email Address',
            controller: _ctrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.mail_outline_rounded,
          ),
          const SizedBox(height: 24),

          widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : GradientButton(
                  label: 'Send Code',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () =>
                      widget.onNext(_ctrl.text.trim().toLowerCase()),
                ),
          const SizedBox(height: 28),

          // Security note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'SECURITY NOTE: ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextSpan(
                    text:
                        'TAKE.HEALTH AI PLATFORM NEVER ASKS FOR YOUR PASSWORD OVER EMAIL. ALL PASSWORD RESETS ARE HANDLED THROUGH OUR SECURE VERIFICATION SYSTEM.',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

// ── Step 2 – OTP ──────────────────────────────────────────────────────────────
class _OtpStep extends StatefulWidget {
  const _OtpStep({
    required this.email,
    required this.isLoading,
    required this.onNext,
    required this.onChangeEmail,
  });
  final String email;
  final bool isLoading;
  final ValueChanged<String> onNext;
  final VoidCallback onChangeEmail;

  @override
  State<_OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<_OtpStep> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Text(
            'RESET ACCESS',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'STEP 2 OF 3 • VERIFY CODE',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'We sent a 4-digit code to\n${widget.email.isEmpty ? 'your email' : widget.email}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          OtpInputField(
            length: 4,
            onChanged: (val) => setState(() => _otp = val),
            onCompleted: (val) => setState(() => _otp = val),
          ),
          const SizedBox(height: 24),
          widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : GradientButton(
                  label: 'Verify Code',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => widget.onNext(_otp),
                ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: widget.onChangeEmail,
              child: RichText(
                text: TextSpan(
                  text: 'Wrong email?  ',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  children: const [
                    TextSpan(
                      text: 'Send to different email',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

// ── Step 3 – New Password ─────────────────────────────────────────────────────
class _NewPasswordStep extends StatefulWidget {
  const _NewPasswordStep({required this.isLoading, required this.onNext});
  final bool isLoading;
  final ValueChanged<String> onNext;

  @override
  State<_NewPasswordStep> createState() => _NewPasswordStepState();
}

class _NewPasswordStepState extends State<_NewPasswordStep> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Text(
            'RESET ACCESS',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'STEP 3 OF 3 • NEW PASSWORD',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          AuthTextField(
            label: 'New Password',
            hint: 'Enter new password',
            isPassword: true,
            controller: _ctrl,
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.lock_outline_rounded,
          ),
          PasswordStrengthIndicator(password: _ctrl.text),
          const SizedBox(height: 28),
          widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : GradientButton(
                  label: 'Reset Password',
                  icon: Icons.check_rounded,
                  onPressed: () => widget.onNext(_ctrl.text),
                ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ── Step 4 – Success ──────────────────────────────────────────────────────────
class _SuccessStep extends StatelessWidget {
  const _SuccessStep({required this.onSignIn});
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.12),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.primary,
              size: 42,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Password Reset\nSuccessfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your password has been updated.\nSign in with your new password to continue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 40),
          GradientButton(label: 'Sign In', onPressed: onSignIn),
        ],
      ),
    );
  }
}
