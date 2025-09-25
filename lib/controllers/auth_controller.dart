import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/dummy_data.dart';

class AuthController extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  // Simple login with dummy validation
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(Duration(seconds: 2));

    // Simple validation - accept any email/password for demo
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = DummyData.currentUser;
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Simple signup
  Future<bool> signup(String firstName, String lastName, String email, String password, String phone) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(Duration(seconds: 2));

    // Create new user with provided data
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phone,
    );
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Logout
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Check if user is logged in (for app initialization)
  Future<void> checkAuthStatus() async {
    // For demo purposes, always start as logged out
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return true; // Always return success for demo
  }
}
