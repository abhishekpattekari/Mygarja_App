import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/auth/presentation/screens/auth_screens/login_screen.dart';
import 'package:mygarja/controllers/auth_controller.dart';
import 'package:mygarja/feature/product/presentation/screens/home/address/address_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('Profile'),
      body: Consumer<AuthController>(
        builder: (context, authController, child) {
          print('ProfileScreen: Building profile screen, isLoggedIn: ${authController.isLoggedIn}');
          
          final user = authController.currentUser;
          
          if (user != null) {
            print('ProfileScreen: User data - First Name: ${user.firstName}, Last Name: ${user.lastName}, Email: ${user.email}');
          } else {
            print('ProfileScreen: No user data available');
          }
          
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2021/04/25/14/30/man-6206540_1280.jpg"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  if (user != null)
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: asset.introStyles(24),
                    )
                  else
                    Text(
                      'Guest User',
                      style: asset.introStyles(24),
                    ),
                  const SizedBox(height: 15),
                  if (user != null)
                    Text(
                      user.email,
                      style: asset.introStyles(16, color: Colors.grey),
                    ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: [
                        setting_btn("Edit Profile", Icons.person),
                        ListTile(
                      minLeadingWidth: 0,
                      leading: Icon(
                        Icons.location_pin,
                        size: 24,
                        color: Colors.black54,
                      ),
                      title: Text(
                        "Address",
                        style: asset.introStyles(18),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AddressScreen.routename);
                      },
                    ),
                        ListTile(
                      minLeadingWidth: 0,
                      leading: Icon(
                        Icons.shopping_bag,
                        size: 24,
                        color: Colors.black54,
                      ),
                      title: Text(
                        "My Orders",
                        style: asset.introStyles(18),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/order-screen');
                      },
                    ),
                        setting_btn("Privacy Policy", Icons.lock_outline_rounded),
                        setting_btn("Help Center", Icons.help),
                        ListTile(
                          minLeadingWidth: 0,
                          leading: Icon(Icons.logout_rounded,
                              size: 30, color: Colors.red.shade300),
                          title: Text(
                            'Logout',
                            style:
                                asset.introStyles(18, color: Colors.red.shade300),
                          ),
                          onTap: () => _showLogoutDialog(context, authController),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ListTile setting_btn(String title, IconData leadingIcon) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -2),
      minLeadingWidth: 0,
      leading: Icon(
        leadingIcon,
        size: 24,
        color: Colors.black54,
      ),
      title: Text(
        title,
        style: asset.introStyles(18),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black54,
      ),
    );
  }

  // 🔴 Logout confirmation dialog
  void _showLogoutDialog(BuildContext context, AuthController authController) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // close dialog
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(ctx).pop(); // close dialog
              print('ProfileScreen: Logout initiated');
              authController.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routename,
                (route) => false, // clear navigation stack
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}