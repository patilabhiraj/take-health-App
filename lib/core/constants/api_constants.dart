abstract final class ApiConstants {
  // Take Health Backend URL
  static const String baseUrl = 'https://ai-healthcare-ip89.onrender.com';

  // ── Auth ──────────────────────────────────────────────────────────────────────
  static const String register         = '/auth/register';
  static const String registerOtp      = '/auth/register-otp';
  static const String registerDoctor   = '/auth/register/doctor';
  static const String login            = '/auth/login';
  static const String logout           = '/auth/logout';
  static const String forgotPassword   = '/auth/forgot-password';
  static const String verifyResetCode  = '/auth/verify-reset-code';
  static const String resetPassword    = '/auth/reset-password';
  static const String profile          = '/auth/profile';
  static const String updateProfile    = '/auth/profile';
  static const String uploadProfilePic = '/auth/upload-profile-picture';

  // ── Health Features (Future) ──────────────────────────────────────────────────
  static const String aiChat           = '/api/ai/chat';
  static const String analysis         = '/api/analysis';
  static const String reports          = '/api/reports';
  static const String dietPlan         = '/api/diet-plan';
}
