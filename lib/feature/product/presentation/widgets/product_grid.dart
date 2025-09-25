import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/data/dummy_data.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final String jsonPath;
  final String title;
  
  const ProductGrid(this.jsonPath, this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, title),
      body: Builder(
          builder: (context) {
            // Use dummy data filtered by category
            final products = DummyData.products;
            
            return GridView.builder(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .65,
                    crossAxisCount: 2,
                    crossAxisSpacing: 7),
                itemBuilder: (context, index) => ProductCard(
                    title: products[index].name,
                    price: products[index].price,
                    image_url: products[index].imageUrl,
                    category: products[index].category));
          }),
    );
  }
}
