import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/auth/presentation/screens/auth_screens/forgot_password_screen.dart';
import 'package:mygarja/feature/auth/presentation/screens/auth_screens/signup_screen.dart';
import 'package:mygarja/feature/product/presentation/screens/home/main_home_screen.dart';
import 'package:mygarja/services/auth_service.dart';
import 'package:mygarja/services/storage_service.dart';
import 'package:mygarja/services/google_sign_in_service.dart';
import 'package:mygarja/models/api/api_user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('LoginScreen: Attempting login with email: ${_emailController.text}');
      
      final ApiUser? user = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (user != null) {
        print('LoginScreen: Login successful for user: ${user.firstName} ${user.lastName}');
        print('LoginScreen: User token: ${user.token}');
        print('LoginScreen: User email: ${user.email}');
        
        // Save token and user data
        await StorageService.saveAuthToken(user.token!);
        await StorageService.saveUserData(user.toJson());
        print('LoginScreen: User data saved to storage');

        // Navigate to MainHomeScreen and remove all previous routes
        print('LoginScreen: Navigating to MainHomeScreen');
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainHomeScreen.routename,
          (route) => false,
        );
      } else {
        print('LoginScreen: Login failed - invalid credentials');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('LoginScreen: Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('LoginScreen: Starting Google Sign-In');
      
      final ApiUser? user = await _googleSignInService.signInWithGoogle();

      if (user != null) {
        print('LoginScreen: Google Sign-In successful, fetching full profile');
        
        // Get full user profile
        final ApiUser? fullUser = await _authService.getProfile();
        
        if (fullUser != null) {
          print('LoginScreen: Full profile fetched successfully');
          print('LoginScreen: Full user data - First Name: ${fullUser.firstName}, Last Name: ${fullUser.lastName}');
          
          // Save token and user data
          await StorageService.saveAuthToken(fullUser.token!);
          await StorageService.saveUserData(fullUser.toJson());
          print('LoginScreen: Full user data saved to storage');

          // Navigate to MainHomeScreen and remove all previous routes
          print('LoginScreen: Navigating to MainHomeScreen');
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainHomeScreen.routename,
            (route) => false,
          );
        } else {
          print('LoginScreen: Failed to get user profile');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to get user profile.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print('LoginScreen: Google Sign-In failed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Sign-In failed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('LoginScreen: Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // ✅ Removed BackAppBar and added a clean AppBar with no back button
      appBar: AppBar(
        automaticallyImplyLeading: false, // ensures no back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(""), // Empty title
      ),

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Login to your account',
                    style: asset.introStyles(55),
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: asset.introStyles(20),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: const IconTheme(
                          data: IconThemeData(color: Colors.grey, size: 25),
                          child: Icon(Icons.email),
                        ),
                        hintText: "Email",
                        prefixIconColor: Colors.grey,
                        hintStyle: asset.introStyles(18, color: Colors.black45),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5)),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    style: asset.introStyles(20),
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: const IconTheme(
                          data: IconThemeData(color: Colors.grey, size: 25),
                          child: Icon(Icons.lock_outline),
                        ),
                        hintText: "Password",
                        prefixIconColor: Colors.grey,
                        hintStyle: asset.introStyles(18, color: Colors.black45),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5)),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  InkWell(
                    onTap: _handleLogin,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(35)),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                            fontSize: 26),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, ForgotPasswordScreen.routename),
                    child: Text(
                      'Forgot the password?',
                      style: asset.introStyles(20),
                    ),
                  ),
                  Text(
                    'or continue with',
                    style: asset.introStyles(20, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          asset.google_logo,
                          width: 35,
                        ),
                        onPressed: _handleGoogleSignIn,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: asset.introStyles(18, color: Colors.black54),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routename);
                        },
                        child: Text(
                          "Sign up",
                          style: asset.introStyles(18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}