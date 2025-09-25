import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/feature/product/presentation/widgets/cart_product_card.dart';
import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/transaction_button.dart';
import 'package:mygarja/data/dummy_data.dart';
import 'package:mygarja/models/product.dart';
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> cartProductData = {
      'title': '',
      'price': '',
      'product_img_url': ''
    };
    // Use dummy data instead of Firebase
    final List<CartItem> cartItems = DummyData.cartItems;
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar('My Cart'),
      body: Builder(
        builder: (BuildContext context) {
          // Show loading state if needed
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
                ],
              ),
            );
          } else {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: (cartItems as List<CartItem>).map<Widget>((CartItem cartItem) {
                cartProductData['title'] = cartItem.product.name;
                cartProductData['price'] = cartItem.product.price;
                cartProductData['product_img_url'] = cartItem.product.imageUrl;
                return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CartProductCard(true,
                        productQuantity: cartItem.quantity,
                        productId: cartItem.product.id.toString(),
                        cartImageUrl: cartItem.product.imageUrl,
                        title: cartItem.product.name,
                        price: cartItem.product.price));
              }).toList(),
            );
          }
        },
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          if (cartItems.isEmpty) {
            return const SizedBox.shrink();
          } else {
            // Calculate total price from dummy data
            double totalPrice = DummyData.getCartTotal();
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
                            cartProductData: (cartItems as List<CartItem>).map<Map<String, String>>((CartItem item) => {
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
