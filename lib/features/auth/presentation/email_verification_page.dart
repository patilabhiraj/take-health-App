import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../app/injection.dart';
import '../domain/usecases/verify_email_otp_usecase.dart';
import '../domain/usecases/resend_email_otp_usecase.dart';
import 'widgets/widgets.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({super.key, required this.email});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _otpControllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    if (_otpCode.length != 6) {
      CustomSnackBar.showError(context, 'Please enter complete OTP');
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final verifyUseCase = sl<VerifyEmailOtpUseCase>();
      final result = await verifyUseCase(widget.email, _otpCode);

      result.fold(
        (failure) {
          if (mounted) CustomSnackBar.showError(context, failure.message);
        },
        (_) {
          logger.info('✅ Email verified successfully');
          if (mounted) {
            CustomSnackBar.showSuccess(context, 'Email verified successfully!');
            context.go(AppRouter.home);
          }
        },
      );
    } catch (e) {
      if (mounted) CustomSnackBar.showError(context, 'Failed to verify OTP');
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);

    try {
      final resendUseCase = sl<ResendEmailOtpUseCase>();
      final result = await resendUseCase(widget.email);

      result.fold(
        (failure) {
          if (mounted) CustomSnackBar.showError(context, failure.message);
        },
        (_) {
          if (mounted) {
            CustomSnackBar.showSuccess(context, 'OTP sent to ${widget.email}');
          }
        },
      );
    } catch (e) {
      if (mounted) CustomSnackBar.showError(context, 'Failed to resend OTP');
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary, size: 20),
          onPressed: () => context.go(AppRouter.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // ── Logo ────────────────────────────────────────────────────────
              const Center(child: AuthLogo(dark: true)),
              const SizedBox(height: 40),

              // ── Icon ────────────────────────────────────────────────────────
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                  child: const Icon(
                    Icons.mark_email_unread_outlined,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Title ───────────────────────────────────────────────────────
              const Text(
                'Verify Your Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We sent a verification code to\n${widget.email}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // ── OTP Input ───────────────────────────────────────────────────
              OtpInputField(
                length: 6,
                onChanged: (_) {},
                onCompleted: (_) => _verifyOtp(),
              ),
              const SizedBox(height: 32),

              // ── Verify button ───────────────────────────────────────────────
              GradientButton(
                label: _isVerifying ? 'Verifying...' : 'Verify Email',
                onPressed: _isVerifying ? () {} : _verifyOtp,
              ),
              const SizedBox(height: 24),

              // ── Resend ──────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                  TextButton(
                    onPressed: _isResending ? null : _resendOtp,
                    child: _isResending
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : const Text(
                            'Resend',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
