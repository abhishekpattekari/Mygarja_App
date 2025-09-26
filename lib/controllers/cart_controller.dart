import 'package:flutter/material.dart';
import '../models/api/api_cart.dart';
import '../models/api/api_cart_item.dart';
import '../models/api/api_product.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class CartController extends ChangeNotifier {
  ApiCart? _cart;
  bool _isLoading = false;
  final CartService _cartService = CartService();

  ApiCart? get cart => _cart;
  bool get isLoading => _isLoading;
  double get totalAmount => _cart?.totalAmount ?? 0.0;
  int get totalItems => _cart?.totalItems ?? 0;
  List<CartItem> get cartItems {
    if (_cart == null) return [];
    
    return _cart!.items.map((apiItem) {
      // Create a mock product since we don't have the full product data in the cart item
      final product = Product(
        id: apiItem.productId,
        name: apiItem.productName,
        price: apiItem.price,
        originalPrice: null,
        discount: null,
        imageUrl: apiItem.imageUrl,
        category: '',
        description: '',
        sizes: [],
        rating: 0.0,
        reviewCount: 0,
      );
      
      return CartItem(
        product: product,
        quantity: apiItem.quantity,
        selectedSize: apiItem.size,
      );
    }).toList();
  }

  // Add to cart
  Future<bool> addToCart(int productId, int quantity) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiCart? updatedCart = await _cartService.addToCart(productId, quantity);
      if (updatedCart != null) {
        _cart = updatedCart;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to add to cart - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Add to cart error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Get cart
  Future<void> getCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiCart? cartData = await _cartService.getCart();
      if (cartData != null) {
        _cart = cartData;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to get cart - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Get cart error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Remove from cart
  Future<bool> removeFromCart(int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiCart? updatedCart = await _cartService.removeFromCart(productId);
      if (updatedCart != null) {
        _cart = updatedCart;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to remove from cart - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Remove from cart error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Update quantity
  Future<bool> updateQuantity(int productId, int quantity) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiCart? updatedCart = await _cartService.updateQuantity(productId, quantity);
      if (updatedCart != null) {
        _cart = updatedCart;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to update quantity - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Update quantity error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Update size
  Future<bool> updateSize(int productId, String size) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiCart? updatedCart = await _cartService.updateSize(productId, size);
      if (updatedCart != null) {
        _cart = updatedCart;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to update size - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Update size error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Clear cart
  Future<bool> clearCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final bool success = await _cartService.clearCart();
      if (success) {
        _cart = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('CartController: Failed to clear cart - possibly authentication issue');
      }
    } catch (e) {
      print('CartController: Clear cart error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}