import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_card.dart';
import 'package:mygarja/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class WishlistScreen extends StatefulWidget {
  static const routename = '/wishlist-screen';

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Use some dummy products as wishlist items
  List<dynamic> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    // Add some products to wishlist for demo
    wishlistItems = DummyData.products.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('My Wishlist'),
      body: wishlistItems.isEmpty
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
                        final product = wishlistItems[index];
                        return Stack(
                          children: [
                            ProductCard(
                              image_url: product.imageUrl,
                              title: product.name,
                              price: product.price,
                              category: product.category,
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wishlistItems.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} removed from wishlist'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
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
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
