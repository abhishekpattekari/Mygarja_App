class ApiOrder {
  final int id;
  final String orderDate;
  final double totalAmount;
  final String status;
  final String productName;
  final int quantity;
  final String size;
  final String image;
  final int userId;
  final String? message;

  ApiOrder({
    required this.id,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.productName,
    required this.quantity,
    required this.size,
    required this.image,
    required this.userId,
    this.message,
  });

  factory ApiOrder.fromJson(Map<String, dynamic> json) {
    return ApiOrder(
      id: json['id'] as int,
      orderDate: json['orderDate'] as String,
      totalAmount: json['totalAmount'] as double,
      status: json['status'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      size: json['size'] as String,
      image: json['image'] as String,
      userId: json['userId'] as int,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'status': status,
      'productName': productName,
      'quantity': quantity,
      'size': size,
      'image': image,
      'userId': userId,
      'message': message,
    };
  }
}