import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/screens/home/main_home_screen.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/auth/presentation/screens/auth_screens/login_screen.dart';
import 'package:mygarja/services/auth_service.dart';
import 'package:mygarja/services/storage_service.dart';
import 'package:mygarja/services/google_sign_in_service.dart';
import 'package:mygarja/models/api/api_user.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routename = '/signup-screen';
  
  const SignUpScreen({Key? key}) : super(key: key);
  
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
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
      final ApiUser? user = await _authService.signup(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );

      if (user != null) {
        // Save token and user data
        await StorageService.saveAuthToken(user.token!);
        await StorageService.saveUserData(user.toJson());

        // Navigate to MainHomeScreen and remove all previous routes
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainHomeScreen.routename,
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signup failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup error: ${e.toString()}'),
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
      final ApiUser? user = await _googleSignInService.signInWithGoogle();

      if (user != null) {
        // Get full user profile
        final ApiUser? fullUser = await _authService.getProfile();
        
        if (fullUser != null) {
          // Save token and user data
          await StorageService.saveAuthToken(fullUser.token!);
          await StorageService.saveUserData(fullUser.toJson());

          // Navigate to MainHomeScreen and remove all previous routes
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainHomeScreen.routename,
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to get user profile.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Sign-In failed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
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
      appBar: BackAppBar(context, ''),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                child: Column(
                  children: [
                    Text(
                      'Create Your Account',
                      style: asset.introStyles(45), // Reduced font size
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _firstNameController,
                      style: asset.introStyles(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child: Icon(Icons.person),
                          ),
                          hintText: "First Name",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNameController,
                      style: asset.introStyles(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child: Icon(Icons.person_outline),
                          ),
                          hintText: "Last Name",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      style: asset.introStyles(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child: Icon(Icons.phone),
                          ),
                          hintText: "Phone Number",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      style: asset.introStyles(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child: Icon(Icons.email_outlined),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: asset.introStyles(20),
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                              data: IconThemeData(color: Colors.grey, size: 25),
                              child: Icon(Icons.lock_outline)),
                          hintText: "Password",
                          suffixIcon: const IconTheme(
                            child: Icon(Icons.remove_red_eye),
                            data: IconThemeData(color: Colors.grey),
                          ),
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
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: _handleSignUp,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(35)),
                        child: Text(
                          "Sign up",
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontSize: 26),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'or continue with',
                      style: asset.introStyles(20, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            asset.google_logo,
                            width: 50,
                            height: 50,
                          ),
                          onPressed: _handleGoogleSignIn,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: asset.introStyles(16, color: Colors.black54),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.routename);
                          },
                          child: Text(
                            "Sign in",
                            style: asset.introStyles(16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}