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
          inverseSurface: AppColors.lightCounterBox,
          onInverseSurface: AppColors.lightCounterBoxText,
          inversePrimary: AppColors.lightPrimary,
          scrim: Color(0x40000000),
          shadow: Color(0x1A000000),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: AppColors.lightForeground, fontWeight: FontWeight.w800),
          headlineMedium: TextStyle(color: AppColors.lightForeground, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(color: AppColors.lightForeground, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: AppColors.lightForeground, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: AppColors.lightForeground),
          bodyMedium: TextStyle(color: AppColors.lightForeground),
          bodySmall: TextStyle(color: AppColors.lightMutedForeground),
          labelLarge: TextStyle(color: AppColors.lightMutedForeground, fontWeight: FontWeight.w600),
        ),
        cardTheme: CardThemeData(
          color: AppColors.lightCard,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderXl2,
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
          fillColor: AppColors.lightCard,
          hintStyle: const TextStyle(color: AppColors.lightMutedForeground),
          border: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.lightInput),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.lightInput),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.lightRing, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.lightDestructive),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightPrimary,
            foregroundColor: AppColors.lightPrimaryForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.lightPrimary,
            side: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: AppColors.lightPrimaryForeground,
          elevation: 4,
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: AppColors.lightNavBar,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.lightCard,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderXl,
            side: const BorderSide(color: AppColors.lightBorder),
          ),
          elevation: 4,
          textStyle: const TextStyle(color: AppColors.lightForeground, fontSize: 14),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.lightCard,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl2),
          elevation: 8,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.lightCard,
          surfaceTintColor: Colors.transparent,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl2),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.lightPrimary;
            return AppColors.lightMutedForeground;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.lightPrimarySurface;
            return AppColors.lightMuted;
          }),
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
          inverseSurface: AppColors.darkCounterBox,
          onInverseSurface: AppColors.darkCounterBoxText,
          inversePrimary: AppColors.darkPrimary,
          scrim: Color(0x80000000),
          shadow: Color(0x4D000000),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: AppColors.darkForeground, fontWeight: FontWeight.w800),
          headlineMedium: TextStyle(color: AppColors.darkForeground, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(color: AppColors.darkForeground, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: AppColors.darkForeground, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: AppColors.darkForeground),
          bodyMedium: TextStyle(color: AppColors.darkForeground),
          bodySmall: TextStyle(color: AppColors.darkMutedForeground),
          labelLarge: TextStyle(color: AppColors.darkMutedForeground, fontWeight: FontWeight.w600),
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderXl2,
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
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.darkInput),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.darkInput),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.darkRing, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderXl,
            borderSide: const BorderSide(color: AppColors.darkDestructive),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkPrimary,
            foregroundColor: AppColors.darkPrimaryForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
            side: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
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
            if (states.contains(WidgetState.selected)) return AppColors.darkPrimary;
            return Colors.transparent;
          }),
          checkColor: const WidgetStatePropertyAll(AppColors.darkPrimaryForeground),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderSm),
          side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.darkPrimary,
          linearTrackColor: AppColors.darkMuted,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkPrimaryForeground,
          elevation: 4,
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: AppColors.darkNavBar,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.darkCard,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderXl,
            side: const BorderSide(color: AppColors.darkBorder),
          ),
          elevation: 8,
          textStyle: const TextStyle(color: AppColors.darkForeground, fontSize: 14),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.darkCard,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl2),
          elevation: 16,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.darkCard,
          surfaceTintColor: Colors.transparent,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderXl2),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.darkPrimary;
            return AppColors.darkMutedForeground;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.darkPrimarySurface;
            return AppColors.darkMuted;
          }),
        ),
      );
}
