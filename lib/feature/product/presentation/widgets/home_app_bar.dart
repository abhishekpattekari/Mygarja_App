import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

PreferredSize MyAppBar() {
  return PreferredSize(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Consumer<AuthController>(
            builder: (context, authController, child) {
              print('HomeAppBar: Building app bar, isLoggedIn: ${authController.isLoggedIn}');
              
              if (authController.isLoggedIn && authController.currentUser != null) {
                final user = authController.currentUser;
                print('HomeAppBar: User data - First Name: ${user!.firstName}, Last Name: ${user.lastName}');
                
                return AppBar(
                  elevation: 0,
                  primary: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2021/04/25/14/30/man-6206540_1280.jpg"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${user.firstName}',
                            style: asset.introStyles(20, color: Colors.black54),
                          ),
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: asset.introStyles(20),
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        asset.notification_bell,
                        width: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        asset.heart,
                        width: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              } else {
                print('HomeAppBar: User not logged in or no user data');
                return AppBar(
                  elevation: 0,
                  primary: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2021/04/25/14/30/man-6206540_1280.jpg"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: asset.introStyles(20, color: Colors.black54),
                          ),
                          Text(
                            'Guest User',
                            style: asset.introStyles(20),
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        asset.notification_bell,
                        width: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        asset.heart,
                        width: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      preferredSize: const Size.fromHeight(60));
}