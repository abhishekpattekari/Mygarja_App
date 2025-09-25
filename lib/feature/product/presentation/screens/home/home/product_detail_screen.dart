import 'package:mygarja/feature/product/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class ProductDetailScreen extends StatelessWidget {
  final String image_url;
  final String title;
  final String price;
  final String category;
  
  const ProductDetailScreen(
    this.image_url, 
    this.title, 
    this.price, 
    this.category, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    String cartbtntitle = "Add to Cart";

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: mediaQuery.height * .5,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(fit: StackFit.expand, children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(
                    image_url,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(.4),
                    child:const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  top: 20,
                  left: 20,
                )
              ]),
            ),
            Container(
              height: mediaQuery.height * .35,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 40),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, -2))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQuery.width * .8,
                            child: Text(
                              title,
                              style: asset.introStyles(25),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                            ),
                          ),
                          Image.asset(
                            asset.heart,
                            width: 28,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.star_half_outlined),
                          Text(
                            ' 4.5  |   ',
                            style: asset.introStyles(16, color: Colors.grey),
                          ),
                          Container(
                            width: 60,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            color: Colors.grey.shade300,
                            child: Text(
                              '8,374 sold',
                              style: asset.introStyles(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: asset.introStyles(
                          23,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '''Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur''',
                        style: asset.introStyles(14, color: Colors.black54),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Quantity",
                        style: asset.introStyles(23),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                          width: 90,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.remove),
                              Text(
                                '1',
                                style: asset.introStyles(25),
                              ),
                              const Icon(Icons.add)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: mediaQuery.height * .1,
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
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
                  '₹$price',
                  style: asset.introStyles(28),
                )
              ],
            ),
            TransactionButton(
              mediaQuery: mediaQuery.width * .65,
              title: cartbtntitle,
              suffixIcon: Image.asset(
                asset.cart,
                color: Colors.white,
              ),
              trasaction_fun: () {
                // Show success message for adding to cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title added to cart!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
