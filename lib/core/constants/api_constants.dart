abstract final class ApiConstants {
  // Take Health Backend URL
  static const String baseUrl = 'https://ai-healthcare-ip89.onrender.com';

  // ── Auth ──────────────────────────────────────────────────────────────────────
  static const String register         = '/api/auth/register';
  static const String registerOtp      = '/api/auth/register-otp';
  static const String requestOtp       = '/api/auth/request-otp'; // Request OTP endpoint
  static const String registerDoctor   = '/api/auth/register/doctor';
  static const String login            = '/api/auth/login';
  static const String logout           = '/api/auth/logout';
  static const String forgotPassword   = '/api/auth/forgot-password';
  static const String verifyResetCode  = '/api/auth/verify-reset-code';
  static const String resetPassword    = '/api/auth/reset-password';
  static const String profile          = '/api/auth/profile';
  static const String updateProfile    = '/api/auth/profile';
  static const String uploadProfilePic = '/api/auth/upload-profile-picture';

  // ── AI Chat ───────────────────────────────────────────────────────────────────
  static const String chat             = '/chat';
  static const String chatHistory      = '/chat/history';
  static const String aiHealthChat     = '/health/ai-chat';

  // ── Health Features (Future) ──────────────────────────────────────────────────
  static const String analysis         = '/api/analysis';
  static const String reports          = '/api/reports';
  static const String dietPlan         = '/api/diet-plan';
}
