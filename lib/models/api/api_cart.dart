import 'api_cart_item.dart';

class ApiCart {
  final int id;
  final int userId;
  final List<ApiCartItem> items;
  final double totalAmount;
  final int totalItems;

  ApiCart({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.totalItems,
  });

  factory ApiCart.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<ApiCartItem> cartItems = itemsList
        .map((item) => ApiCartItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return ApiCart(
      id: json['id'] as int,
      userId: json['userId'] as int,
      items: cartItems,
      totalAmount: json['totalAmount'] as double,
      totalItems: json['totalItems'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'totalItems': totalItems,
    };
  }
}