import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductController extends ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = "All";
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  ProductController() {
    loadProducts();
  }

  // Load products and categories
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    // Simulate loading delay
    await Future.delayed(Duration(seconds: 1));

    _products = DummyData.products;
    _categories = DummyData.categories;
    _filteredProducts = _products;

    _isLoading = false;
    notifyListeners();
  }

  // Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    
    if (category == "All") {
      _filteredProducts = _products;
    } else {
      _filteredProducts = DummyData.getProductsByCategory(category);
    }
    
    notifyListeners();
  }

  // Get latest products
  List<Product> getLatestProducts() {
    return DummyData.getLatestProducts();
  }

  // Get product by ID
  Product? getProductById(int id) {
    return DummyData.getProductById(id);
  }

  // Search products
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _selectedCategory == "All" 
          ? _products 
          : DummyData.getProductsByCategory(_selectedCategory);
    } else {
      _filteredProducts = _products
          .where((product) => 
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
