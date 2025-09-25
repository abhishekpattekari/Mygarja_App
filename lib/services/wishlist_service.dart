import 'api_service.dart';
import '../models/api/api_wishlist_item.dart';
import 'dart:convert';

class WishlistService extends ApiService {
  // Add to Wishlist
  Future<bool> addToWishlist(int userId, int productId) async {
    try {
      final response = await post(
        '/user/wishlist/$userId/$productId',
        {},
        authenticated: true,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Add to wishlist error: $e');
      return false;
    }
  }

  // Remove from Wishlist
  Future<bool> removeFromWishlist(int userId, int productId) async {
    try {
      final response = await delete(
        '/user/wishlist/$userId/$productId',
        authenticated: true,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Remove from wishlist error: $e');
      return false;
    }
  }

  // Remove by Wishlist ID
  Future<bool> removeWishlistItem(int wishlistId) async {
    try {
      final response = await delete(
        '/user/wishlist/$wishlistId',
        authenticated: true,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Remove wishlist item error: $e');
      return false;
    }
  }

  // Get User Wishlist
  Future<List<ApiWishlistItem>?> getUserWishlist(int userId) async {
    try {
      final response = await get(
        '/user/wishlist/user/$userId',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<ApiWishlistItem> wishlistItems = jsonData
            .map((item) => ApiWishlistItem.fromJson(item as Map<String, dynamic>))
            .toList();
        return wishlistItems;
      } else {
        // Handle error
        print('Get user wishlist failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Get user wishlist error: $e');
      return null;
    }
  }
}