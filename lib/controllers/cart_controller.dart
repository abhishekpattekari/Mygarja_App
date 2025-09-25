import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class CartController extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;
  int get itemCount => DummyData.getCartItemCount();
  double get totalAmount => DummyData.getCartTotal();

  CartController() {
    _cartItems = DummyData.cartItems;
  }

  // Add item to cart
  void addToCart(Product product, String selectedSize, {int quantity = 1}) {
    // Check if item already exists in cart
    int existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == selectedSize,
    );

    if (existingIndex >= 0) {
      // Update quantity if item exists
      _cartItems[existingIndex].quantity += quantity;
    } else {
      // Add new item
      _cartItems.add(CartItem(
        product: product,
        quantity: quantity,
        selectedSize: selectedSize,
      ));
    }

    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(int productId, String selectedSize) {
    _cartItems.removeWhere(
      (item) => item.product.id == productId && item.selectedSize == selectedSize,
    );
    notifyListeners();
  }

  // Update item quantity
  void updateQuantity(int productId, String selectedSize, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId, selectedSize);
      return;
    }

    int index = _cartItems.indexWhere(
      (item) => item.product.id == productId && item.selectedSize == selectedSize,
    );

    if (index >= 0) {
      _cartItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Check if product is in cart
  bool isInCart(int productId, String selectedSize) {
    return _cartItems.any(
      (item) => item.product.id == productId && item.selectedSize == selectedSize,
    );
  }

  // Get cart item for specific product and size
  CartItem? getCartItem(int productId, String selectedSize) {
    try {
      return _cartItems.firstWhere(
        (item) => item.product.id == productId && item.selectedSize == selectedSize,
      );
    } catch (e) {
      return null;
    }
  }
}
