import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mygarja/feature/product/presentation/widgets/carousel_card.dart';
import 'package:mygarja/feature/product/presentation/widgets/home_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/input_field.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_grid.dart';
import 'package:mygarja/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:provider/provider.dart';
import 'carousel_list.dart';
import 'most_popular_product_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/home-screen';
  
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = "clothes";
  
  @override
  void initState() {
    super.initState();
    // Load latest products when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false).loadLatestProducts();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputField(
              'Search',
              (v) {},
              const Icon(Icons.search_rounded),
              const Icon(Icons.menu_open_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Special Offers',
                  style: asset.introStyles(22),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarouselList(),
                        ));
                  },
                  child: Text(
                    'See all',
                    style: asset.introStyles(18),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(1, 2))
                ],
              ),
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/json/carousel.json"),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      var carouselData = json.decode(snapshot.data.toString())
                          as List<dynamic>;
                      List<Widget> itemsList = [];
                      for (int i = 0; i < carouselData.length; i++) {
                        itemsList.add(CarouselCard(
                            carouselData[i]['discount'],
                            carouselData[i]['heading'],
                            carouselData[i]['subtitle'],
                            carouselData[i]['image_url']));
                      }

                      return CarouselSlider(
                        items: itemsList,
                        options: CarouselOptions(
                            autoPlay: true, viewportFraction: 1),
                      );
                    }
                  }),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/json/category.json"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  var categoryData =
                      json.decode(snapshot.data.toString()) as List<dynamic>;
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: categoryData.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return categoryTile(categoryData[index]['icon'],
                            categoryData[index]['title'], () {
                          String categoryName = categoryData[index]['title'];
                          // Capitalize first letter for proper display
                          String formattedName = categoryName[0].toUpperCase() + categoryName.substring(1);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductGrid(formattedName),
                              ));
                        });
                      });
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Most Popular',
                  style: asset.introStyles(22),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MostPopularProductScreen(),
                    ));
                  },
                  child: Text(
                    'See all',
                    style: asset.introStyles(18),
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/json/category.json'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    var categoryData =
                        json.decode(snapshot.data.toString()) as List<dynamic>;
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => asset.category_chip(
                          categoryData[index]['title'], category),
                      itemCount: categoryData.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell categoryTile(String url, String title, VoidCallback movenext) {
    return InkWell(
      onTap: () => movenext(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              url,
              width: 30,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: asset.introStyles(14),
          )
        ],
      ),
    );
  }
}