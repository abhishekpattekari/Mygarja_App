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

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Add to wishlist failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        
        // Check if this is an authentication issue
        if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
          print('Add to wishlist failed: Authentication error - token may be invalid or expired');
        }
        
        return false;
      }
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

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Remove from wishlist failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        
        // Check if this is an authentication issue
        if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
          print('Remove from wishlist failed: Authentication error - token may be invalid or expired');
        }
        
        return false;
      }
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

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Remove wishlist item failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        
        // Check if this is an authentication issue
        if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
          print('Remove wishlist item failed: Authentication error - token may be invalid or expired');
        }
        
        return false;
      }
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
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiWishlistItem> wishlistItems = jsonData
              .map((item) => ApiWishlistItem.fromJson(item as Map<String, dynamic>))
              .toList();
          return wishlistItems;
        } else {
          print('Get user wishlist failed: Response is not valid JSON');
          print('Response status: ${response.statusCode}');
          print('Response content: ${response.body.substring(0, 500)}');
          
          // Check if this is an authentication issue
          if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
            print('Get user wishlist failed: Authentication error - token may be invalid or expired');
          }
          
          return null;
        }
      } else {
        // Handle error
        print('Get user wishlist failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        return null;
      }
    } catch (e) {
      print('Get user wishlist error: $e');
      return null;
    }
  }
}