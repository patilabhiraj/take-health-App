import 'package:flutter/material.dart';
import 'app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Border Radius Tokens
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppRadius {
  static const double sm  = AppColors.radius - 4;  // 6px
  static const double md  = AppColors.radius - 2;  // 8px
  static const double lg  = AppColors.radius;       // 10px
  static const double xl  = AppColors.radius + 4;  // 14px
  static const double xl2 = AppColors.radius + 8;  // 18px
  static const double xl3 = AppColors.radius + 12; // 22px
  static const double xl4 = AppColors.radius + 16; // 26px

  static BorderRadius borderSm  = BorderRadius.circular(sm);
  static BorderRadius borderMd  = BorderRadius.circular(md);
  static BorderRadius borderLg  = BorderRadius.circular(lg);
  static BorderRadius borderXl  = BorderRadius.circular(xl);
  static BorderRadius borderXl2 = BorderRadius.circular(xl2);
  static BorderRadius borderXl3 = BorderRadius.circular(xl3);
  static BorderRadius borderXl4 = BorderRadius.circular(xl4);
}

// ─────────────────────────────────────────────────────────────────────────────
// Take Health App Theme
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTheme {
  // ── Light Theme ──────────────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.lightPrimary,
          onPrimary: AppColors.lightPrimaryForeground,
          primaryContainer: AppColors.lightSecondary,
          onPrimaryContainer: AppColors.lightSecondaryForeground,
          secondary: AppColors.lightSecondary,
          onSecondary: AppColors.lightSecondaryForeground,
          secondaryContainer: AppColors.lightMuted,
          onSecondaryContainer: AppColors.lightMutedForeground,
          tertiary: AppColors.lightAccent,
          onTertiary: AppColors.lightAccentForeground,
          tertiaryContainer: AppColors.lightAccent,
          onTertiaryContainer: AppColors.lightAccentForeground,
          error: AppColors.lightDestructive,
          onError: AppColors.lightPrimaryForeground,
          errorContainer: Color(0xFFFEE2E2),
          onErrorContainer: AppColors.lightDestructive,
          surface: AppColors.lightCard,
          onSurface: AppColors.lightCardForeground,
          surfaceContainerHighest: AppColors.lightMuted,
          onSurfaceVariant: AppColors.lightMutedForeground,
          outline: AppColors.lightBorder,
          outlineVariant: AppColors.lightRing,
          inverseSurface: AppColors.lightPrimary,
          onInverseSurface: AppColors.lightPrimaryForeground,
          inversePrimary: AppColors.lightMuted,
          scrim: Color(0x40000000),
          shadow: Color(0x1F000000),
        ),
        cardTheme: CardThemeData(
          color: AppColors.lightCard,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderLg,
            side: const BorderSide(color: AppColors.lightBorder),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightBackground,
          foregroundColor: AppColors.lightForeground,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightBackground,
          hintStyle: const TextStyle(color: AppColors.lightMutedForeground),
          border: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.lightInput),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.lightInput),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.lightRing, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.lightDestructive),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightPrimary,
            foregroundColor: AppColors.lightPrimaryForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.lightPrimary,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.lightBorder,
          thickness: 1,
          space: 1,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.lightPrimary;
            return Colors.transparent;
          }),
          checkColor: const WidgetStatePropertyAll(AppColors.lightPrimaryForeground),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderSm),
          side: const BorderSide(color: AppColors.lightBorder, width: 1.5),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.lightPrimary,
          linearTrackColor: AppColors.lightMuted,
        ),
      );

  // ── Dark Theme ───────────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.darkPrimary,
          onPrimary: AppColors.darkPrimaryForeground,
          primaryContainer: AppColors.darkSecondary,
          onPrimaryContainer: AppColors.darkSecondaryForeground,
          secondary: AppColors.darkSecondary,
          onSecondary: AppColors.darkSecondaryForeground,
          secondaryContainer: AppColors.darkMuted,
          onSecondaryContainer: AppColors.darkMutedForeground,
          tertiary: AppColors.darkAccent,
          onTertiary: AppColors.darkAccentForeground,
          tertiaryContainer: AppColors.darkAccent,
          onTertiaryContainer: AppColors.darkAccentForeground,
          error: AppColors.darkDestructive,
          onError: AppColors.darkBackground,
          errorContainer: Color(0xFF450A0A),
          onErrorContainer: AppColors.darkDestructive,
          surface: AppColors.darkCard,
          onSurface: AppColors.darkCardForeground,
          surfaceContainerHighest: AppColors.darkMuted,
          onSurfaceVariant: AppColors.darkMutedForeground,
          outline: AppColors.darkBorder,
          outlineVariant: AppColors.darkRing,
          inverseSurface: AppColors.darkPrimary,
          onInverseSurface: AppColors.darkPrimaryForeground,
          inversePrimary: AppColors.darkMuted,
          scrim: Color(0x80000000),
          shadow: Color(0x4D000000),
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderLg,
            side: const BorderSide(color: AppColors.darkBorder),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.darkForeground,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCard,
          hintStyle: const TextStyle(color: AppColors.darkMutedForeground),
          border: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.darkInput),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.darkInput),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.darkRing, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderMd,
            borderSide: const BorderSide(color: AppColors.darkDestructive),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkPrimary,
            foregroundColor: AppColors.darkPrimaryForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.darkForeground,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.darkBorder,
          thickness: 1,
          space: 1,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.primary;
            return Colors.transparent;
          }),
          checkColor: const WidgetStatePropertyAll(AppColors.lightPrimaryForeground),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderSm),
          side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.darkMuted,
        ),
      );
}
