import 'api_service.dart';
import '../models/api/api_cart.dart';
import 'dart:convert';

class CartService extends ApiService {
  // Add to Cart
  Future<ApiCart?> addToCart(int productId, int quantity) async {
    try {
      final response = await post(
        '/user/cart/add/$productId?quantity=$quantity',
        {},
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiCart.fromJson(jsonData);
      } else {
        // Handle error
        print('Add to cart failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Add to cart error: $e');
      return null;
    }
  }

  // Get Cart
  Future<ApiCart?> getCart() async {
    try {
      final response = await get('/user/cart', authenticated: true);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiCart.fromJson(jsonData);
      } else {
        // Handle error
        print('Get cart failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Get cart error: $e');
      return null;
    }
  }

  // Remove from Cart
  Future<ApiCart?> removeFromCart(int productId) async {
    try {
      final response = await delete(
        '/user/cart/remove/$productId',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiCart.fromJson(jsonData);
      } else {
        // Handle error
        print('Remove from cart failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Remove from cart error: $e');
      return null;
    }
  }

  // Update Quantity
  Future<ApiCart?> updateQuantity(int productId, int quantity) async {
    try {
      final response = await put(
        '/user/cart/update/$productId?quantity=$quantity',
        {},
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiCart.fromJson(jsonData);
      } else {
        // Handle error
        print('Update quantity failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Update quantity error: $e');
      return null;
    }
  }

  // Update Size
  Future<ApiCart?> updateSize(int productId, String size) async {
    try {
      final response = await put(
        '/user/cart/size/$productId?size=$size',
        {},
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiCart.fromJson(jsonData);
      } else {
        // Handle error
        print('Update size failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Update size error: $e');
      return null;
    }
  }

  // Clear Cart
  Future<bool> clearCart() async {
    try {
      final response = await delete('/user/cart/clear', authenticated: true);

      return response.statusCode == 200;
    } catch (e) {
      print('Clear cart error: $e');
      return false;
    }
  }
}