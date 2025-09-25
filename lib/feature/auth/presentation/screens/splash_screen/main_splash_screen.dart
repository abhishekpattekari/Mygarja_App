import 'package:mygarja/feature/auth/presentation/screens/auth_screens/login_screen.dart';
import 'package:mygarja/feature/product/presentation/screens/home/main_home_screen.dart';
import 'package:mygarja/services/storage_service.dart';
import 'package:mygarja/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    print('MainSplashScreen: Checking auth status');
    
    // Add a small delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    // Check auth status using the auth controller
    final authController = Provider.of<AuthController>(context, listen: false);
    await authController.checkAuthStatus();
    
    if (authController.isLoggedIn) {
      print('MainSplashScreen: User is logged in, navigating to MainHomeScreen');
      // User is already logged in, go to main home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, MainHomeScreen.routename);
      }
    } else {
      print('MainSplashScreen: User is not logged in, showing introduction screens');
      // User is not logged in, show introduction screens
      if (mounted) {
        setState(() {
          // This will trigger a rebuild to show the introduction screens
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500)), // Small delay for UI
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Still checking auth status
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          asset.logo2,
                          width: 200,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Mygarja",
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircularProgressIndicator(
                    color: Colors.black87,
                    strokeWidth: 7,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          } else {
            // After the small delay, check auth status
            final authController = Provider.of<AuthController>(context);
            
            if (authController.isLoading) {
              // Still checking auth status
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            asset.logo2,
                            width: 200,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Mygarja",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircularProgressIndicator(
                      color: Colors.black87,
                      strokeWidth: 7,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            } else if (authController.isLoggedIn) {
              // User is authenticated
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            asset.logo2,
                            width: 200,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Mygarja",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircularProgressIndicator(
                      color: Colors.black87,
                      strokeWidth: 7,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            } else {
              // User is not authenticated, show introduction screens
              return IntroductionScreen(
                showNextButton: true,
                showDoneButton: true,
                onDone: () {
                  Navigator.popAndPushNamed(context, LoginScreen.routename);
                },
                done: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontFamily: 'Ubuntu'),
                ),
                dotsDecorator: const DotsDecorator(
                  activeColor: Colors.black87,
                  activeSize: Size(20, 35),
                ),
                next: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black54,
                  size: 30,
                ),
                pages: [
                  pageviewmodel(
                      'We provide high quality products for you',
                      asset.splash_login),
                  pageviewmodel(
                      'Your satisfaction is our number one priority',
                      asset.splash_check),
                  pageviewmodel(
                      "Let's fulfill your daily needs with Evira right now!",
                      asset.splash_store),
                ],
              );
            }
          }
        },
      ),
    );
  }

  PageViewModel pageviewmodel(String title, String image) {
    return PageViewModel(
      titleWidget: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Ubuntu',
          fontSize: 40,
        ),
      ),
      body: '',
      image: Image.asset(image),
      decoration: const PageDecoration(
        imageFlex: 2,
        bodyFlex: 1,
        bodyPadding: EdgeInsets.zero,
        imagePadding: EdgeInsets.all(10),
      ),
    );
  }
}