import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../models/api/api_user.dart';
import '../services/storage_service.dart';

class AuthController extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  // Login with API
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    print('AuthController: Login called with email: $email');

    try {
      final ApiUser? apiUser = await _authService.login(
        email: email,
        password: password,
      );

      if (apiUser != null) {
        print('AuthController: API login successful, creating User object');
        print('AuthController: API User data - First Name: ${apiUser.firstName}, Last Name: ${apiUser.lastName}');
        
        _currentUser = User(
          id: apiUser.id,
          firstName: apiUser.firstName,
          lastName: apiUser.lastName,
          email: apiUser.email,
          phoneNumber: apiUser.phoneNumber ?? '',
        );
        
        print('AuthController: Created User object - First Name: ${_currentUser!.firstName}, Last Name: ${_currentUser!.lastName}');
        _isLoggedIn = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('AuthController: Login error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Signup with API
  Future<bool> signup(String firstName, String lastName, String email, String password, String phone) async {
    _isLoading = true;
    notifyListeners();
    print('AuthController: Signup called with email: $email');

    try {
      final ApiUser? apiUser = await _authService.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone,
      );

      if (apiUser != null) {
        print('AuthController: API signup successful, creating User object');
        print('AuthController: API User data - First Name: ${apiUser.firstName}, Last Name: ${apiUser.lastName}');
        
        _currentUser = User(
          id: apiUser.id,
          firstName: apiUser.firstName,
          lastName: apiUser.lastName,
          email: apiUser.email,
          phoneNumber: apiUser.phoneNumber ?? '',
        );
        
        print('AuthController: Created User object - First Name: ${_currentUser!.firstName}, Last Name: ${_currentUser!.lastName}');
        _isLoggedIn = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('AuthController: Signup error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Logout
  void logout() {
    print('AuthController: Logout called');
    _authService.clearToken();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
    print('AuthController: Logout completed');
  }

  // Check if user is logged in (for app initialization)
  Future<void> checkAuthStatus() async {
    print('AuthController: Checking auth status');
    
    try {
      // Check for stored token
      final String? token = await StorageService.getAuthToken();
      if (token != null) {
        print('AuthController: Found stored token, fetching user profile');
        _authService.setToken(token);
        
        // Try to get user profile
        final ApiUser? apiUser = await _authService.getProfile();
        if (apiUser != null) {
          print('AuthController: User profile fetched successfully');
          print('AuthController: User data - First Name: ${apiUser.firstName}, Last Name: ${apiUser.lastName}');
          
          _currentUser = User(
            id: apiUser.id,
            firstName: apiUser.firstName,
            lastName: apiUser.lastName,
            email: apiUser.email,
            phoneNumber: apiUser.phoneNumber ?? '',
          );
          
          _isLoggedIn = true;
          print('AuthController: User is logged in');
        } else {
          print('AuthController: Failed to fetch user profile, clearing auth data');
          await StorageService.clearAllAuthData();
          _isLoggedIn = false;
          _currentUser = null;
        }
      } else {
        print('AuthController: No stored token found');
        _isLoggedIn = false;
        _currentUser = null;
      }
    } catch (e) {
      print('AuthController: Error checking auth status: $e');
      _isLoggedIn = false;
      _currentUser = null;
    }
    
    notifyListeners();
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    print('AuthController: Forgot password called for email: $email');

    // In a real implementation, this would call the API
    await Future.delayed(Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    print('AuthController: Forgot password completed');
    return true; // Always return success for demo
  }
}