import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_card.dart';
import 'package:mygarja/controllers/wishlist_controller.dart';
import 'package:mygarja/controllers/auth_controller.dart';
import 'package:mygarja/models/api/api_wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class WishlistScreen extends StatefulWidget {
  static const routename = '/wishlist-screen';

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // Load wishlist data when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Provider.of<AuthController>(context, listen: false);
      if (authController.isLoggedIn && authController.currentUser != null) {
        Provider.of<WishlistController>(context, listen: false)
            .getUserWishlist(authController.currentUser!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('My Wishlist'),
      body: Consumer2<WishlistController, AuthController>(
        builder: (context, wishlistController, authController, child) {
          final wishlistItems = wishlistController.wishlistItems;
          
          // Load wishlist if not already loaded and user is logged in
          if (authController.isLoggedIn && 
              authController.currentUser != null && 
              wishlistItems.isEmpty && 
              !wishlistController.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              wishlistController.getUserWishlist(authController.currentUser!);
            });
          }
          
          if (wishlistController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return wishlistItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Your wishlist is empty',
                        style: asset.introStyles(24, color: Colors.grey[600]!),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add some products to your wishlist',
                        style: asset.introStyles(16, color: Colors.grey[500]!),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Wishlist (${wishlistItems.length} items)',
                        style: asset.introStyles(22, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: wishlistItems.length,
                          itemBuilder: (context, index) {
                            final item = wishlistItems[index];
                            return WishlistItemCard(item: item);
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class WishlistItemCard extends StatelessWidget {
  final ApiWishlistItem item;
  
  const WishlistItemCard({Key? key, required this.item}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProductCard(
          image_url: item.productImage,
          title: item.productName,
          price: item.productPrice,
          category: '', // Category not available in wishlist item
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              final authController = Provider.of<AuthController>(context, listen: false);
              if (authController.isLoggedIn && authController.currentUser != null) {
                Provider.of<WishlistController>(context, listen: false)
                    .removeWishlistItem(item.wishlistId)
                    .then((success) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.productName} removed from wishlist'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}