import 'package:mygarja/feature/auth/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routename = '/forgot-password';
  
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleForgotPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password reset email sent successfully"),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, "Forgot Password"),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password?',
                    style: asset.introStyles(40),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enter your email address and we\'ll send you a link to reset your password.',
                    style: asset.introStyles(16, color: Colors.grey[600]!),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    style: asset.introStyles(18),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: const IconTheme(
                        data: IconThemeData(color: Colors.grey, size: 25),
                        child: Icon(Icons.email_outlined),
                      ),
                      hintText: "Email",
                      prefixIconColor: Colors.grey,
                      hintStyle: asset.introStyles(16, color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black, width: 1.5),
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: _handleForgotPassword,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Text(
                        "Send Reset Link",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
