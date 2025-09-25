import 'api_service.dart';
import '../models/api/api_order.dart';
import 'dart:convert';

class OrderService extends ApiService {
  // Buy Now
  Future<ApiOrder?> buyNow(int productId, int quantity, String size) async {
    try {
      final response = await post(
        '/user/orders/buy-now',
        {
          'productId': productId,
          'quantity': quantity,
          'size': size,
        },
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiOrder.fromJson(jsonData);
      } else {
        // Handle error
        print('Buy now failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Buy now error: $e');
      return null;
    }
  }

  // Checkout Cart
  Future<ApiOrder?> checkoutCart(int addressId) async {
    try {
      final response = await post(
        '/user/orders/checkout?addressId=$addressId',
        {},
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiOrder.fromJson(jsonData);
      } else {
        // Handle error
        print('Checkout cart failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Checkout cart error: $e');
      return null;
    }
  }

  // Create Razorpay Order
  Future<Map<String, dynamic>?> createRazorpayOrder(
      int amount, String currency, String receipt) async {
    try {
      final response = await post(
        '/user/orders/create-razorpay-order',
        {
          'amount': amount,
          'currency': currency,
          'receipt': receipt,
        },
        authenticated: true,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Handle error
        print('Create Razorpay order failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Create Razorpay order error: $e');
      return null;
    }
  }

  // Verify Payment
  Future<ApiOrder?> verifyPayment(
      String razorpayOrderId, String razorpayPaymentId, String razorpaySignature, int addressId) async {
    try {
      final response = await post(
        '/user/orders/verify-payment?addressId=$addressId',
        {
          'razorpay_order_id': razorpayOrderId,
          'razorpay_payment_id': razorpayPaymentId,
          'razorpay_signature': razorpaySignature,
        },
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiOrder.fromJson(jsonData);
      } else {
        // Handle error
        print('Verify payment failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Verify payment error: $e');
      return null;
    }
  }

  // Get Order History
  Future<List<ApiOrder>?> getOrderHistory() async {
    try {
      final response = await get('/user/orders/history', authenticated: true);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<ApiOrder> orders = jsonData
            .map((item) => ApiOrder.fromJson(item as Map<String, dynamic>))
            .toList();
        return orders;
      } else {
        // Handle error
        print('Get order history failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Get order history error: $e');
      return null;
    }
  }
}