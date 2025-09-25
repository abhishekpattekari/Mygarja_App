import 'dart:convert';
import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_card.dart';
import 'package:mygarja/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class MostPopularProductScreen extends StatefulWidget {
  static const routename = "/most-popular-product-screen";

  const MostPopularProductScreen({Key? key}) : super(key: key);

  @override
  State<MostPopularProductScreen> createState() =>
      _MostPopularProductScreenState();
}

class _MostPopularProductScreenState extends State<MostPopularProductScreen> {
  String category = "clothes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, "Most Popular"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/json/category.json'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      var categoryData = json.decode(snapshot.data.toString())
                          as List<dynamic>;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                category = categoryData[index]['title'];
                                category = category.toLowerCase();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: asset.category_chip(
                                  categoryData[index]['title'], category),
                            ),
                          );
                        },
                        itemCount: categoryData.length,
                      );
                    }
                  },
                ),
              ),
              Builder(
                  builder: (context) {
                    // Use dummy data for most popular products
                    final products = DummyData.products;
                    return Expanded(
                      child: GridView.builder(
                          itemCount: products.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: .65,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7),
                          itemBuilder: (context, index) => ProductCard(
                              title: products[index].name,
                              price: products[index].price,
                              image_url: products[index].imageUrl,
                              category: products[index].category,)),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
