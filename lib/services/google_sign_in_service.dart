import 'package:google_sign_in/google_sign_in.dart';
import 'auth_service.dart';
import '../models/api/api_user.dart';

class GoogleSignInService {
  final AuthService _authService = AuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  // Sign in with Google
  Future<ApiUser?> signInWithGoogle() async {
    try {
      print('GoogleSignInService: Starting Google Sign-In flow');
      
      // Sign out from previous sessions
      await _googleSignIn.signOut();
      print('GoogleSignInService: Previous session signed out');
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        print('GoogleSignInService: Google user authenticated - Email: ${googleUser.email}');
        
        // Get the authentication details
        final GoogleSignInAuthentication googleAuth = 
            await googleUser.authentication;
        
        print('GoogleSignInService: Sending user info to backend');
        // Send the user info to your backend
        final ApiUser? user = await _authService.googleLoginCallback(
          id: googleUser.id,
          email: googleUser.email,
          givenName: googleUser.displayName?.split(' ').first ?? '',
          familyName: googleUser.displayName?.split(' ').last ?? '',
          picture: googleUser.photoUrl ?? '',
        );
        
        if (user != null) {
          print('GoogleSignInService: Google Sign-In successful for user: ${user.firstName} ${user.lastName}');
        } else {
          print('GoogleSignInService: Backend authentication failed');
        }
        
        return user;
      } else {
        print('GoogleSignInService: Google Sign-In cancelled or failed');
      }
      
      return null;
    } catch (error) {
      print('GoogleSignInService: Google Sign-In error: $error');
      return null;
    }
  }

  // Sign out from Google
  Future<void> signOut() async {
    print('GoogleSignInService: Signing out from Google');
    await _googleSignIn.signOut();
    _authService.clearToken();
    print('GoogleSignInService: Signed out successfully');
  }
}