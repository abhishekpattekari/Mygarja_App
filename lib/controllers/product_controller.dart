import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../models/api/api_product.dart';
import '../models/api/api_category.dart';

class ProductController extends ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = "All";
  bool _isLoading = false;
  final ProductService _productService = ProductService();

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  ProductController() {
    loadProducts();
  }

  // Convert API Product to App Product
  Product _convertApiProduct(ApiProduct apiProduct) {
    return Product(
      id: apiProduct.id,
      name: apiProduct.productName,
      price: apiProduct.price,
      originalPrice: apiProduct.originalPrice,
      discount: apiProduct.discount,
      imageUrl: apiProduct.imageUrl,
      category: apiProduct.category,
      description: apiProduct.description,
      sizes: [
        if (apiProduct.xs != null) 'XS',
        if (apiProduct.m != null) 'M',
        if (apiProduct.l != null) 'L',
        if (apiProduct.xl != null) 'XL',
        if (apiProduct.xxl != null) 'XXL',
      ],
      rating: 4.5, // API doesn't provide rating, using default
      reviewCount: 0, // API doesn't provide review count, using default
    );
  }

  // Convert API Category to App Category
  Category _convertApiCategory(ApiCategory apiCategory) {
    return Category(
      id: apiCategory.id,
      name: apiCategory.categoryName,
      imageUrl: '', // API doesn't provide image URL for categories
    );
  }

  // Load products and categories from API
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load products
      final List<ApiProduct>? apiProducts = await _productService.getAllProducts();
      if (apiProducts != null) {
        _products = apiProducts.map((apiProduct) => _convertApiProduct(apiProduct)).toList();
      }

      // Load categories
      final List<ApiCategory>? apiCategories = await _productService.getAllCategories();
      if (apiCategories != null) {
        _categories = apiCategories.map((apiCategory) => _convertApiCategory(apiCategory)).toList();
      }

      _filteredProducts = _products;
    } catch (e) {
      print('Error loading products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load products by category from API
  Future<List<Product>> loadProductsByCategory(String category) async {
    try {
      final List<ApiProduct>? apiProducts = await _productService.getProductsByCategory(category);
      if (apiProducts != null) {
        return apiProducts.map((apiProduct) => _convertApiProduct(apiProduct)).toList();
      }
      return [];
    } catch (e) {
      print('Error loading products by category: $e');
      return [];
    }
  }

  // Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    
    if (category == "All") {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) => product.category == category)
          .toList();
    }
    
    notifyListeners();
  }

  // Get latest products
  List<Product> getLatestProducts() {
    // Return first 4 products as latest
    return _products.take(4).toList();
  }

  // Get product by ID
  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _selectedCategory == "All" 
          ? _products 
          : _products.where((product) => product.category == _selectedCategory).toList();
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