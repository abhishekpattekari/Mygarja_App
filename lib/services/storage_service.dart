import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';

  // Save auth token
  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Clear auth token
  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }

  // Save user data
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final String userDataString = jsonEncode(userData);
    await prefs.setString(_userDataKey, userDataString);
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString(_userDataKey);
    
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    
    return null;
  }

  // Clear user data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }

  // Clear all auth data
  static Future<void> clearAllAuthData() async {
    await clearAuthToken();
    await clearUserData();
  }
}