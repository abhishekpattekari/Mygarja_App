import 'package:mygarja/feature/auth/presentation/screens/auth_screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

import 'login_screen.dart';

class AuthMainScreen extends StatelessWidget {
  static const routename = '/authmainscreen';

  const AuthMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              asset.splash_login,
              width: 360,
            ),
            Text(
              "Let's you in",
              style: asset.introStyles(50),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loginButton('Continue with facebook', asset.facebook_logo),
                  loginButton('Continue with Google', asset.google_logo),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Phone authentication coming soon!'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 32,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Continue with Number",
                          style: asset.introStyles(20),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'or',
              style: asset.introStyles(20, color: Colors.black54),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(LoginScreen.routename);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(35)),
                child: const Text(
                  'Sign in with password',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Ubuntu', fontSize: 24),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?",
                  style: asset.introStyles(16, color: Colors.black54),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routename);
                  },
                  child: Text(
                    "Sign up",
                    style: asset.introStyles(16),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Row loginButton(String title, String iconpath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconpath,
          width: 35,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: asset.introStyles(20),
        )
      ],
    );
  }
}
