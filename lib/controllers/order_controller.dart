import 'package:flutter/material.dart';
import '../models/api/api_order.dart';
import '../services/order_service.dart';

class OrderController extends ChangeNotifier {
  List<ApiOrder> _orders = [];
  bool _isLoading = false;
  final OrderService _orderService = OrderService();

  List<ApiOrder> get orders => _orders;
  bool get isLoading => _isLoading;

  // Buy now
  Future<ApiOrder?> buyNow(int productId, int quantity, String size) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiOrder? order = await _orderService.buyNow(productId, quantity, size);
      if (order != null) {
        // Add to orders list
        _orders.insert(0, order);
        _isLoading = false;
        notifyListeners();
        return order;
      } else {
        // Handle error - possibly authentication issue
        print('OrderController: Failed to buy now - possibly authentication issue');
      }
    } catch (e) {
      print('OrderController: Buy now error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  // Checkout cart
  Future<ApiOrder?> checkoutCart(int addressId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiOrder? order = await _orderService.checkoutCart(addressId);
      if (order != null) {
        // Add to orders list
        _orders.insert(0, order);
        _isLoading = false;
        notifyListeners();
        return order;
      } else {
        // Handle error - possibly authentication issue
        print('OrderController: Failed to checkout cart - possibly authentication issue');
      }
    } catch (e) {
      print('OrderController: Checkout cart error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  // Create Razorpay order
  Future<Map<String, dynamic>?> createRazorpayOrder(int amount, String currency, String receipt) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? order = await _orderService.createRazorpayOrder(amount, currency, receipt);
      if (order != null) {
        _isLoading = false;
        notifyListeners();
        return order;
      } else {
        // Handle error - possibly authentication issue
        print('OrderController: Failed to create Razorpay order - possibly authentication issue');
      }
    } catch (e) {
      print('OrderController: Create Razorpay order error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  // Verify payment
  Future<ApiOrder?> verifyPayment(String razorpayOrderId, String razorpayPaymentId, String razorpaySignature, int addressId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final ApiOrder? order = await _orderService.verifyPayment(razorpayOrderId, razorpayPaymentId, razorpaySignature, addressId);
      if (order != null) {
        // Add to orders list
        _orders.insert(0, order);
        _isLoading = false;
        notifyListeners();
        return order;
      } else {
        // Handle error - possibly authentication issue
        print('OrderController: Failed to verify payment - possibly authentication issue');
      }
    } catch (e) {
      print('OrderController: Verify payment error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  // Get order history
  Future<void> getOrderHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<ApiOrder>? orders = await _orderService.getOrderHistory();
      if (orders != null) {
        _orders = orders;
      } else {
        // Handle error - possibly authentication issue
        print('OrderController: Failed to get order history - possibly authentication issue');
      }
    } catch (e) {
      print('OrderController: Get order history error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}