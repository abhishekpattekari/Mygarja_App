import 'package:mygarja/feature/auth/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/screens/home/main_home_screen.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
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

    // Simulate signup delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // For demo purposes, any data works
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
      appBar: BackAppBar(context, ''),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Create Your Account',
                    style: asset.introStyles(55),
                  ),
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
                  Text(
                    'or continue with',
                    style: asset.introStyles(20, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        asset.facebook_logo,
                        width: 60,
                        height: 60,
                      ),
                      Image.asset(
                        asset.google_logo,
                        width: 60,
                        height: 60,
                      ),
                      Image.asset(
                        asset.apple_logo,
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ],
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
