import 'api_service.dart';
import '../models/api/api_user.dart';
import 'dart:convert';

class AuthService extends ApiService {
  // User Registration
  Future<ApiUser?> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      print('AuthService: Attempting signup for email: $email');
      
      final response = await post('/auth/signup', {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'role': 'USER',
        'provider': 'LOCAL',
      });

      print('AuthService: Signup response status: ${response.statusCode}');
      print('AuthService: Signup response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final user = ApiUser.fromJson(jsonData);
        // Set token for future authenticated requests
        setToken(user.token!);
        print('AuthService: Signup successful for user: ${user.firstName} ${user.lastName}');
        return user;
      } else {
        // Handle error
        print('AuthService: Signup failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('AuthService: Signup error: $e');
      return null;
    }
  }

  // User Login
  Future<ApiUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      print('AuthService: Attempting login for email: $email');
      
      final response = await post('/auth/login', {
        'email': email,
        'password': password,
      });

      print('AuthService: Login response status: ${response.statusCode}');
      print('AuthService: Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = ApiUser.fromJson(jsonData);
        // Set token for future authenticated requests
        setToken(user.token!);
        print('AuthService: Login successful for user: ${user.firstName} ${user.lastName}');
        return user;
      } else {
        // Handle error
        print('AuthService: Login failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('AuthService: Login error: $e');
      return null;
    }
  }

  // Google OAuth Login
  Future<void> googleLogin() async {
    try {
      // This would typically open a web view for Google OAuth
      // Implementation depends on the specific OAuth package used
      print('AuthService: Redirecting to Google OAuth');
    } catch (e) {
      print('AuthService: Google login error: $e');
    }
  }

  // Google OAuth Callback
  Future<ApiUser?> googleLoginCallback({
    required String id,
    required String email,
    required String givenName,
    required String familyName,
    required String picture,
  }) async {
    try {
      print('AuthService: Google login callback for email: $email');
      print('AuthService: User info - id: $id, givenName: $givenName, familyName: $familyName');
      
      final response = await post('/auth/google/callback', {
        'userInfo': {
          'id': id,
          'email': email,
          'given_name': givenName,
          'family_name': familyName,
          'picture': picture,
        }
      });

      print('AuthService: Google login callback response status: ${response.statusCode}');
      print('AuthService: Google login callback response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final token = jsonData['token'] as String;
        
        // Create a user object with the token
        final user = ApiUser(
          id: 0, // ID will be retrieved from profile endpoint
          email: email,
          firstName: givenName,
          lastName: familyName,
          role: 'USER',
          token: token,
        );
        
        // Set token for future authenticated requests
        setToken(token);
        print('AuthService: Google login callback successful');
        return user;
      } else {
        // Handle error
        print('AuthService: Google login callback failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('AuthService: Google login callback error: $e');
      return null;
    }
  }

  // Get User Profile
  Future<ApiUser?> getProfile() async {
    try {
      print('AuthService: Fetching user profile');
      
      final response = await get('/common/showProfile', authenticated: true);

      print('AuthService: Get profile response status: ${response.statusCode}');
      print('AuthService: Get profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = ApiUser.fromJson(jsonData);
        print('AuthService: Get profile successful for user: ${user.firstName} ${user.lastName}');
        return user;
      } else {
        // Handle error
        print('AuthService: Get profile failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('AuthService: Get profile error: $e');
      return null;
    }
  }

  // Update Password
  Future<bool> updatePassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      print('AuthService: Updating password for email: $email');
      
      final response = await put('/common/updatePassword', {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'role': 'USER',
        'provider': 'LOCAL',
      }, authenticated: true);

      print('AuthService: Update password response status: ${response.statusCode}');
      final success = response.statusCode == 200;
      print('AuthService: Update password result: $success');
      return success;
    } catch (e) {
      print('AuthService: Update password error: $e');
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      print('AuthService: Resetting password');
      
      final response = await post('/common/reset-password', {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }, authenticated: true);

      print('AuthService: Reset password response status: ${response.statusCode}');
      print('AuthService: Reset password response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final success = jsonData['success'] == true;
        print('AuthService: Reset password result: $success');
        return success;
      }
      print('AuthService: Reset password failed with status: ${response.statusCode}');
      return false;
    } catch (e) {
      print('AuthService: Reset password error: $e');
      return false;
    }
  }
}