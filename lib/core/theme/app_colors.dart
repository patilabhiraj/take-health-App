import 'package:flutter/material.dart';

/// Quick theme-aware color helpers
extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get cBg => isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get cFg => isDark ? AppColors.darkForeground : AppColors.lightForeground;
  Color get cCard => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get cBorder => isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get cMuted => isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;
  Color get cError => isDark ? AppColors.darkDestructive : AppColors.lightDestructive;
}

// ─────────────────────────────────────────────────────────────────────────────
// Take Health App Color Tokens
// Primary brand: Dark Green (#1B5E20 / #2E7D32)
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  // ── Radius ──────────────────────────────────────────────────────────────────
  static const double radius = 10.0;

  // ── Take Health Brand Colors ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF1B5E20);        // Dark green
  static const Color primaryHover = Color(0xFF145214);   // Darker green
  static const Color primaryLight = Color(0xFF2E7D32);   // Medium green
  static const Color primarySurface = Color(0xFFE8F5E9); // Light green surface

  // ── LIGHT MODE ───────────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightForeground = Color(0xFF0F1A0F);

  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF0F1A0F);

  static const Color lightPrimary = Color(0xFF1B5E20);
  static const Color lightPrimaryForeground = Color(0xFFFFFFFF);

  static const Color lightSecondary = Color(0xFFE8F5E9);
  static const Color lightSecondaryForeground = Color(0xFF1B5E20);

  static const Color lightMuted = Color(0xFFF1F8F1);
  static const Color lightMutedForeground = Color(0xFF6B7B6B);

  static const Color lightAccent = Color(0xFFE8F5E9);
  static const Color lightAccentForeground = Color(0xFF1B5E20);

  static const Color lightDestructive = Color(0xFFDC2626);

  static const Color lightBorder = Color(0xFFD4E8D4);
  static const Color lightInput = Color(0xFFD4E8D4);
  static const Color lightRing = Color(0xFF4CAF50);

  // ── DARK MODE ────────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0A0F0A);
  static const Color darkForeground = Color(0xFFF0FAF0);

  static const Color darkCard = Color(0xFF111811);
  static const Color darkCardForeground = Color(0xFFF0FAF0);

  static const Color darkPrimary = Color(0xFFE8F5E9);
  static const Color darkPrimaryForeground = Color(0xFF1B5E20);

  static const Color darkSecondary = Color(0xFF1A2A1A);
  static const Color darkSecondaryForeground = Color(0xFFF0FAF0);

  static const Color darkMuted = Color(0xFF1A2A1A);
  static const Color darkMutedForeground = Color(0xFF7A9A7A);

  static const Color darkAccent = Color(0xFF1A2A1A);
  static const Color darkAccentForeground = Color(0xFFF0FAF0);

  static const Color darkDestructive = Color(0xFFF87171);

  static const Color darkBorder = Color(0x1A4CAF50);
  static const Color darkInput = Color(0x264CAF50);
  static const Color darkRing = Color(0xFF2E7D32);

  // ── Charts ───────────────────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF2E7D32);
  static const Color chart2 = Color(0xFF0EA5B0);
  static const Color chart3 = Color(0xFF4CAF50);
  static const Color chart4 = Color(0xFF81C784);
  static const Color chart5 = Color(0xFFA5D6A7);
}
