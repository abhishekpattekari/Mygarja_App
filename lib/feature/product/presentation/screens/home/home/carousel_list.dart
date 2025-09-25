import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_card.dart';
import 'package:mygarja/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselList extends StatelessWidget {
  static const routename = '/carousel_list';
  
  const CarouselList({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context,"Special Offers"),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          // Use latest products from API for special offers
          final products = productController.latestProducts;
          
          if (products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(1, 1.1))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ProductCard(
                  image_url: product.imageUrl,
                  title: product.name,
                  price: product.price,
                  category: product.category,
                ),
              );
            },
          );
        },
      ),
    );
  }
}