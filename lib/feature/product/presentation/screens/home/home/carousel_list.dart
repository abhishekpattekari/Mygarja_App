import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/product_card.dart';
import 'package:mygarja/data/dummy_data.dart';
import 'package:flutter/material.dart';

class CarouselList extends StatelessWidget {
  static const routename = '/carousel_list';
  
  const CarouselList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context,"Special Offers"),
      body: Builder(
        builder: (BuildContext context) {
          // Use dummy data for special offers
          final products = DummyData.products.take(4).toList();
          
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
