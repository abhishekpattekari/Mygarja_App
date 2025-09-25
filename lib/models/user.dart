import 'product.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
  });

  String get fullName => '$firstName $lastName';
}

class CartItem {
  final Product product;
  int quantity;
  final String selectedSize;

  CartItem({
    required this.product,
    required this.quantity,
    required this.selectedSize,
  });

  double get totalPrice => double.parse(product.price) * quantity;
}

class Order {
  final int id;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final DateTime orderDate;
  final String shippingAddress;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.shippingAddress,
  });
}
