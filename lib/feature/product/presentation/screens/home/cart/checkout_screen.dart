import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/cart_product_card.dart';
import 'package:mygarja/feature/product/presentation/widgets/transaction_button.dart';

import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

import 'choose_shipping_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, String>> cartProductData;

  const CheckoutScreen({
    Key? key,
    required this.cartProductData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Address',
              style: asset.introStyles(24),
            ),
            shipping_address_tile(
                "Home",
                '''502 Bay Dr.
Chandler, AZ 85224''',
                "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png"),
            Text(
              'Orders List',
              style: asset.introStyles(24),
            ),
            SizedBox(
              height: mediaquery.height * .60,
              child: Builder(
                builder: (BuildContext context) {
                  if (cartProductData.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black87,
                        strokeWidth: 7,
                      ),
                    );
                  } else {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: cartProductData.map((item) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: CartProductCard(false,
                                productQuantity: 1,
                                productId: '1',
                                cartImageUrl: item['product_img_url']!,
                                title: item['title']!,
                                price: item['price']!));
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: TransactionButton(
          mediaQuery: MediaQuery.of(context).size.width * .9,
          verticalpadding: 20,
          title: 'Continue to Paytment',
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
          ),
          trasaction_fun: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChooseShippingScreen(),
            ));
          },
        ),
      ),
    );
  }

  ListTile shipping_address_tile(String title, String address, String image) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(20),
      ),
      subtitle: Text(
        address,
        style: asset.introStyles(16, color: Colors.grey),
      ),
      trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          )),
      leading: SizedBox(
        height: 55,
        width: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
