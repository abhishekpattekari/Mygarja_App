import 'package:flutter/material.dart';
import '../models/api/api_wishlist_item.dart';
import '../services/wishlist_service.dart';
import '../models/user.dart';

class WishlistController extends ChangeNotifier {
  List<ApiWishlistItem> _wishlistItems = [];
  bool _isLoading = false;
  final WishlistService _wishlistService = WishlistService();

  List<ApiWishlistItem> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;
  int get wishlistCount => _wishlistItems.length;

  // Add to wishlist
  Future<bool> addToWishlist(User user, int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final bool success = await _wishlistService.addToWishlist(user.id, productId);
      if (success) {
        // Refresh wishlist to get the new item
        await getUserWishlist(user);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('WishlistController: Failed to add to wishlist - possibly authentication issue');
      }
    } catch (e) {
      print('WishlistController: Add to wishlist error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Remove from wishlist
  Future<bool> removeFromWishlist(User user, int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final bool success = await _wishlistService.removeFromWishlist(user.id, productId);
      if (success) {
        // Remove item from local list
        _wishlistItems.removeWhere((item) => item.productId == productId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('WishlistController: Failed to remove from wishlist - possibly authentication issue');
      }
    } catch (e) {
      print('WishlistController: Remove from wishlist error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Remove wishlist item by ID
  Future<bool> removeWishlistItem(int wishlistId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final bool success = await _wishlistService.removeWishlistItem(wishlistId);
      if (success) {
        // Remove item from local list
        _wishlistItems.removeWhere((item) => item.wishlistId == wishlistId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('WishlistController: Failed to remove wishlist item - possibly authentication issue');
      }
    } catch (e) {
      print('WishlistController: Remove wishlist item error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Get user wishlist
  Future<void> getUserWishlist(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<ApiWishlistItem>? items = await _wishlistService.getUserWishlist(user.id);
      if (items != null) {
        _wishlistItems = items;
      } else {
        // Handle error - possibly authentication issue
        print('WishlistController: Failed to get user wishlist - possibly authentication issue');
      }
    } catch (e) {
      print('WishlistController: Get user wishlist error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Check if product is in wishlist
  bool isInWishlist(int productId) {
    return _wishlistItems.any((item) => item.productId == productId);
  }
}