import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/controllers/product_controller.dart';
import 'package:mygarja/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_card.dart';

class ProductGrid extends StatefulWidget {
  final String title;
  
  const ProductGrid(this.title, {Key? key}) : super(key: key);
  
  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool _isLoading = false;
  List<Product> _categoryProducts = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryProducts();
  }

  Future<void> _loadCategoryProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final productController = Provider.of<ProductController>(context, listen: false);
      // Use the product service to get products by category
      final products = await productController.loadProductsByCategory(widget.title);
      setState(() {
        _categoryProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading products for category ${widget.title}: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, widget.title),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categoryProducts.isEmpty
              ? const Center(
                  child: Text('No products found in this category'),
                )
              : GridView.builder(
                  itemCount: _categoryProducts.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .65,
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    title: _categoryProducts[index].name,
                    price: _categoryProducts[index].price,
                    image_url: _categoryProducts[index].imageUrl,
                    category: _categoryProducts[index].category,
                  ),
                ),
    );
  }
}