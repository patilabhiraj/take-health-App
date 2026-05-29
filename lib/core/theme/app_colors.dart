import 'package:flutter/material.dart';

/// Quick theme-aware color helpers
extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // ── Core Semantic Shortcuts ──────────────────────────────────────────────
  Color get cBg => isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get cFg => isDark ? AppColors.darkForeground : AppColors.lightForeground;
  Color get cCard => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get cBorder => isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get cMuted => isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;
  Color get cError => isDark ? AppColors.darkDestructive : AppColors.lightDestructive;

  // ── Extended Shortcuts ───────────────────────────────────────────────────
  Color get cPrimary => isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
  Color get cPrimarySurface => isDark ? AppColors.darkPrimarySurface : AppColors.lightPrimarySurface;
  Color get cWarmSurface => isDark ? AppColors.darkWarmSurface : AppColors.lightWarmSurface;
  Color get cTextSecondary => isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;
  Color get cSuccess => isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
  Color get cWarning => isDark ? AppColors.darkWarning : AppColors.lightWarning;
  Color get cInfo => isDark ? AppColors.darkInfo : AppColors.lightInfo;
  Color get cNavBar => isDark ? AppColors.darkNavBar : AppColors.lightNavBar;
  Color get cNavBarActive => isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
  Color get cNavBarInactive => isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;
  Color get cCounterBox => isDark ? AppColors.darkCounterBox : AppColors.lightCounterBox;
  Color get cCounterText => isDark ? AppColors.darkCounterBoxText : AppColors.lightCounterBoxText;
  Color get cShadow => isDark ? AppColors.darkShadow : AppColors.lightShadow;
}

// ─────────────────────────────────────────────────────────────────────────────
// Take Health App Color Tokens
// Primary brand: Teal-Green (#2A9D8F / #3DBAA8)
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  // ── Radius ──────────────────────────────────────────────────────────────────
  static const double radius = 10.0;

  // ── Take Health Brand Colors ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF2A9D8F);         // Teal-green
  static const Color primaryHover = Color(0xFF238579);    // Darker teal
  static const Color primaryLight = Color(0xFF52B5A8);    // Medium teal
  static const Color primarySurface = Color(0xFFE6F5F3);  // Light teal surface

  // ── Semantic Colors (shared) ─────────────────────────────────────────────────
  static const Color protein = Color(0xFFEF6C6C);         // Warm red for protein
  static const Color carbs = Color(0xFF5B9BD5);            // Blue for carbs
  static const Color fats = Color(0xFF66BB6A);             // Green for fats

  // ── LIGHT MODE ───────────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFAFBFC);
  static const Color lightForeground = Color(0xFF1A2332);

  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF1A2332);

  static const Color lightPrimary = Color(0xFF2A9D8F);
  static const Color lightPrimaryForeground = Color(0xFFFFFFFF);
  static const Color lightPrimarySurface = Color(0xFFE6F5F3);

  static const Color lightSecondary = Color(0xFFE6F5F3);
  static const Color lightSecondaryForeground = Color(0xFF2A9D8F);

  static const Color lightMuted = Color(0xFFF1F5F9);
  static const Color lightMutedForeground = Color(0xFF64748B);

  static const Color lightAccent = Color(0xFFE6F5F3);
  static const Color lightAccentForeground = Color(0xFF2A9D8F);

  static const Color lightDestructive = Color(0xFFE63946);

  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightInput = Color(0xFFE2E8F0);
  static const Color lightRing = Color(0xFF2A9D8F);

  static const Color lightSuccess = Color(0xFF4CAF50);
  static const Color lightWarning = Color(0xFFF4A261);
  static const Color lightInfo = Color(0xFF3B82F6);

  static const Color lightWarmSurface = Color(0xFFFDF6EE);
  static const Color lightNavBar = Color(0xFFE6F5F3);
  static const Color lightCounterBox = Color(0xFF1A2332);
  static const Color lightCounterBoxText = Color(0xFFFFFFFF);
  static const Color lightShadow = Color(0x0D000000);

  // ── DARK MODE ────────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkForeground = Color(0xFFF0F4F8);

  static const Color darkCard = Color(0xFF1A2027);
  static const Color darkCardForeground = Color(0xFFF0F4F8);

  static const Color darkPrimary = Color(0xFF3DBAA8);
  static const Color darkPrimaryForeground = Color(0xFF0F1419);
  static const Color darkPrimarySurface = Color(0xFF1A3330);

  static const Color darkSecondary = Color(0xFF1A3330);
  static const Color darkSecondaryForeground = Color(0xFFF0F4F8);

  static const Color darkMuted = Color(0xFF1E293B);
  static const Color darkMutedForeground = Color(0xFF94A3B8);

  static const Color darkAccent = Color(0xFF1A3330);
  static const Color darkAccentForeground = Color(0xFFF0F4F8);

  static const Color darkDestructive = Color(0xFFFF6B6B);

  static const Color darkBorder = Color(0xFF2D3748);
  static const Color darkInput = Color(0xFF2D3748);
  static const Color darkRing = Color(0xFF3DBAA8);

  static const Color darkSuccess = Color(0xFF66BB6A);
  static const Color darkWarning = Color(0xFFF4A261);
  static const Color darkInfo = Color(0xFF60A5FA);

  static const Color darkWarmSurface = Color(0xFF1E1A15);
  static const Color darkNavBar = Color(0xFF1A2027);
  static const Color darkCounterBox = Color(0xFFF0F4F8);
  static const Color darkCounterBoxText = Color(0xFF0F1419);
  static const Color darkShadow = Color(0x33000000);

  // ── Charts ───────────────────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF2A9D8F);
  static const Color chart2 = Color(0xFFE76F51);
  static const Color chart3 = Color(0xFFF4A261);
  static const Color chart4 = Color(0xFF264653);
  static const Color chart5 = Color(0xFFE9C46A);
}
