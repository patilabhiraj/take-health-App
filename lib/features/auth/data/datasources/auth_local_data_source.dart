import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> savePendingRegistration(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getPendingRegistration();
  Future<void> deletePendingRegistration();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  static const String _tokenKey = 'take_health_auth_token';
  static const String _pendingRegistrationKey = 'take_health_pending_registration';

  @override
  Future<void> saveToken(String token) async {
    try {
      await secureStorage.write(key: _tokenKey, value: token);
    } catch (secureError) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token);
      } catch (_) {}
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      final token = await secureStorage.read(key: _tokenKey);
      if (token != null && token.isNotEmpty) return token;
    } catch (_) {}

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      if (token != null && token.isNotEmpty) return token;
    } catch (_) {}

    return null;
  }

  @override
  Future<void> deleteToken() async {
    try {
      await secureStorage.delete(key: _tokenKey);
    } catch (_) {}
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (_) {}
  }

  @override
  Future<void> savePendingRegistration(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data);
      await prefs.setString(_pendingRegistrationKey, jsonString);
    } catch (_) {}
  }

  @override
  Future<Map<String, dynamic>?> getPendingRegistration() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_pendingRegistrationKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<void> deletePendingRegistration() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingRegistrationKey);
    } catch (_) {}
  }
}
