import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/auth/presentation/screens/auth_screens/forgot_password_screen.dart';
import 'package:mygarja/feature/auth/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/screens/home/main_home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routename = 'login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate login delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // For demo purposes, any email/password combination works
    Navigator.pushNamedAndRemoveUntil(
      context, 
      MainHomeScreen.routename, 
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BackAppBar(context, ""),
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
                    child: Text(
                      "Sign In",
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Ubuntu', fontSize: 26),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routename),
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
                    Image.asset(
                      asset.facebook_logo,
                      width: 35,
                    ),
                    Image.asset(
                      asset.google_logo,
                      width: 35,
                    ),
                    Icon(Icons.phone, size: 32)
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
                      onTap: () {},
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
