class ApiCartItem {
  final int id;
  final int productId;
  final String productName;
  final String price;
  final int quantity;
  final String size;
  final String imageUrl;
  final double totalPrice;

  ApiCartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.size,
    required this.imageUrl,
    required this.totalPrice,
  });

  factory ApiCartItem.fromJson(Map<String, dynamic> json) {
    return ApiCartItem(
      id: json['id'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      price: json['price'] as String,
      quantity: json['quantity'] as int,
      size: json['size'] as String,
      imageUrl: json['imageUrl'] as String,
      totalPrice: json['totalPrice'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'size': size,
      'imageUrl': imageUrl,
      'totalPrice': totalPrice,
    };
  }
}