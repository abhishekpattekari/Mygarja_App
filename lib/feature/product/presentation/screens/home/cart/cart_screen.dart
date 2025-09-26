import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/product/presentation/widgets/cart_product_card.dart';
import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/transaction_button.dart';
import 'package:mygarja/models/product.dart';
import 'package:mygarja/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Load cart data when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartController>(context, listen: false).getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar('My Cart'),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          final List<CartItem> cartItems = cartController.cartItems;
          
          // Show loading state if needed
          if (cartController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your cart is empty',
                    style: asset.introStyles(24, color: Colors.grey[600]!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add some products to your cart',
                    style: asset.introStyles(16, color: Colors.grey[500]!),
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: cartItems.map<Widget>((CartItem cartItem) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: CartProductCard(
                    true,
                    productQuantity: cartItem.quantity,
                    productId: cartItem.product.id.toString(),
                    cartImageUrl: cartItem.product.imageUrl,
                    title: cartItem.product.name,
                    price: cartItem.product.price,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      bottomNavigationBar: Consumer<CartController>(
        builder: (context, cartController, child) {
          final List<CartItem> cartItems = cartController.cartItems;
          
          if (cartController.isLoading || cartItems.isEmpty) {
            return const SizedBox.shrink();
          } else {
            // Calculate total price from cart controller
            double totalPrice = cartController.totalAmount;
            int priceData = totalPrice.toInt();
            return SizedBox(
              height: mediaQuery.height * .1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total Price',
                          style: asset.introStyles(16),
                        ),
                        Text(
                          "₹" + asset.numberFormat(priceData),
                          style: asset.introStyles(28),
                        )
                      ],
                    ),
                    TransactionButton(
                      mediaQuery: mediaQuery.width * .65,
                      title: 'Checkout',
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                      trasaction_fun: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            cartProductData: cartItems.map<Map<String, String>>((CartItem item) => {
                              'title': item.product.name,
                              'price': item.product.price,
                              'product_img_url': item.product.imageUrl,
                            }).toList(),
                          ),
                        ));
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}