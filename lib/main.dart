import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/address_controller.dart';
import 'controllers/wishlist_controller.dart';
import 'feature/auth/presentation/screens/auth_screens/auth_main_screen.dart';
import 'feature/auth/presentation/screens/auth_screens/login_screen.dart';
import 'feature/auth/presentation/screens/auth_screens/signup_screen.dart';
import 'feature/auth/presentation/screens/auth_screens/forgot_password_screen.dart';
import 'feature/auth/presentation/screens/splash_screen/main_splash_screen.dart';
import 'feature/product/presentation/screens/home/cart/cart_screen.dart';
import 'feature/product/presentation/screens/home/home/carousel_list.dart';
import 'feature/product/presentation/screens/home/home/home_screen.dart';
import 'feature/product/presentation/screens/home/home/most_popular_product_screen.dart';
import 'feature/product/presentation/screens/home/wishlist/wishlist_screen.dart';
import 'feature/product/presentation/screens/home/main_home_screen.dart';
import 'feature/product/presentation/screens/home/order/order_screen.dart';
import 'feature/product/presentation/screens/home/address/address_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => AddressController()),
        ChangeNotifierProvider(create: (context) => WishlistController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainSplashScreen(),
        AuthMainScreen.routename: (context) => AuthMainScreen(),
        SignUpScreen.routename: (context) => SignUpScreen(),
        LoginScreen.routename: (context) => LoginScreen(),
        ForgotPasswordScreen.routename: (context) => ForgotPasswordScreen(),
        HomeScreen.routename: (context) => HomeScreen(),
        CarouselList.routename: (context) => CarouselList(),
        MostPopularProductScreen.routename: (context) => MostPopularProductScreen(),
        CartScreen.routename: (context) => CartScreen(),
        WishlistScreen.routename: (context) => WishlistScreen(),
        MainHomeScreen.routename: (context) => MainHomeScreen(),
        OrderScreen.routename: (context) => OrderScreen(),
        AddressScreen.routename: (context) => AddressScreen(),
      },
    );
  }
}