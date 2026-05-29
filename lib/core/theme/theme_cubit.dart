import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persisted dark/light mode toggle cubit.
/// Saves the user's choice to SharedPreferences under [_key].
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadSavedTheme();
  }

  static const String _key = 'take_health_theme_mode';

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == 'dark') {
      emit(ThemeMode.dark);
    } else if (saved == 'system') {
      emit(ThemeMode.system);
    } else {
      emit(ThemeMode.light);
    }
  }

  Future<void> toggleTheme() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(next);
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  bool get isDark => state == ThemeMode.dark;
}
