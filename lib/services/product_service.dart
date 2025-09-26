import 'api_service.dart';
import '../models/api/api_product.dart';
import '../models/api/api_category.dart';
import 'dart:convert';

class ProductService extends ApiService {
  // Get All Products
  Future<List<ApiProduct>?> getAllProducts() async {
    try {
      final response = await get('/public/getAllProducts');

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiProduct> products = jsonData
              .map((item) => ApiProduct.fromJson(item as Map<String, dynamic>))
              .toList();
          return products;
        } else {
          print('Get all products failed: Response is not valid JSON');
          print('Response content: ${response.body.substring(0, 200)}');
          return null;
        }
      } else {
        // Handle error
        print('Get all products failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 200)}');
        return null;
      }
    } catch (e) {
      print('Get all products error: $e');
      return null;
    }
  }

  // Get Products by Category
  Future<List<ApiProduct>?> getProductsByCategory(String category) async {
    try {
      final response = await get('/public/getProductByCategory?category=$category');

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiProduct> products = jsonData
              .map((item) => ApiProduct.fromJson(item as Map<String, dynamic>))
              .toList();
          return products;
        } else {
          print('Get products by category failed: Response is not valid JSON');
          print('Response content: ${response.body.substring(0, 200)}');
          return null;
        }
      } else {
        // Handle error
        print('Get products by category failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 200)}');
        return null;
      }
    } catch (e) {
      print('Get products by category error: $e');
      return null;
    }
  }

  // Get Latest Products
  Future<List<ApiProduct>?> getLatestProducts() async {
    try {
      final response = await get('/public/getLatestProducts');

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiProduct> products = jsonData
              .map((item) => ApiProduct.fromJson(item as Map<String, dynamic>))
              .toList();
          return products;
        } else {
          print('Get latest products failed: Response is not valid JSON');
          print('Response content: ${response.body.substring(0, 200)}');
          return null;
        }
      } else {
        // Handle error
        print('Get latest products failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 200)}');
        return null;
      }
    } catch (e) {
      print('Get latest products error: $e');
      return null;
    }
  }

  // Get Product by ID
  Future<ApiProduct?> getProductById(int id) async {
    try {
      final response = await get('/public/getProductById/$id');

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final jsonData = jsonDecode(response.body);
          return ApiProduct.fromJson(jsonData);
        } else {
          print('Get product by ID failed: Response is not valid JSON');
          print('Response content: ${response.body.substring(0, 200)}');
          return null;
        }
      } else {
        // Handle error
        print('Get product by ID failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 200)}');
        return null;
      }
    } catch (e) {
      print('Get product by ID error: $e');
      return null;
    }
  }

  // Get All Categories
  Future<List<ApiCategory>?> getAllCategories() async {
    try {
      print('ProductService: Fetching all categories');
      final response = await get('/category/all');

      print('ProductService: Categories response status: ${response.statusCode}');
      print('ProductService: Categories response body: ${response.body.substring(0, min(response.body.length, 200))}');

      if (response.statusCode == 200) {
        // Check if response is actually JSON
        if (response.body.startsWith('{') || response.body.startsWith('[')) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiCategory> categories = jsonData
              .map((item) => ApiCategory.fromJson(item as Map<String, dynamic>))
              .toList();
          print('ProductService: Successfully fetched ${categories.length} categories');
          return categories;
        } else {
          print('ProductService: Categories response is not JSON: ${response.body.substring(0, 100)}');
          return null;
        }
      } else {
        // Handle error
        print('Get all categories failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 200)}');
        return null;
      }
    } catch (e) {
      print('Get all categories error: $e');
      return null;
    }
  }
}