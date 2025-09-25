import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/api/api_order.dart';

class OrderController extends ChangeNotifier {
  List<ApiOrder> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<ApiOrder> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final OrderService _orderService = OrderService();

  // Fetch order history
  Future<void> fetchOrderHistory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<ApiOrder>? orders = await _orderService.getOrderHistory();
      if (orders != null) {
        _orders = orders;
      }
    } catch (e) {
      _error = 'Failed to load orders: $e';
      print('Order fetch error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}