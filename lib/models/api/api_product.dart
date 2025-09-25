class ApiProduct {
  final int id;
  final String productName;
  final String price;
  final String? originalPrice;
  final String? discount;
  final int quantity;
  final bool isActive;
  final String description;
  final String? xs;
  final String? m;
  final String? l;
  final String? xl;
  final String? xxl;
  final String imageUrl;
  final String imagePublicId;
  final String category;
  final String? date;
  final String? time;
  final List<dynamic> reviews;

  ApiProduct({
    required this.id,
    required this.productName,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.quantity,
    required this.isActive,
    required this.description,
    this.xs,
    this.m,
    this.l,
    this.xl,
    this.xxl,
    required this.imageUrl,
    required this.imagePublicId,
    required this.category,
    this.date,
    this.time,
    required this.reviews,
  });

  factory ApiProduct.fromJson(Map<String, dynamic> json) {
    return ApiProduct(
      id: json['id'] as int,
      productName: json['productName'] as String,
      price: json['price'] as String,
      originalPrice: json['originalPrice'] as String?,
      discount: json['discount'] as String?,
      quantity: json['quantity'] as int,
      isActive: json['isActive'] == '1' || json['isActive'] == 1 || json['isActive'] == true,
      description: json['description'] as String,
      xs: json['XS'] as String?,
      m: json['M'] as String?,
      l: json['L'] as String?,
      xl: json['XL'] as String?,
      xxl: json['XXL'] as String?,
      imageUrl: json['imageUrl'] as String,
      imagePublicId: json['imagePublicId'] as String,
      category: json['category'] as String,
      date: json['date'] as String?,
      time: json['time'] as String?,
      reviews: json['reviews'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'quantity': quantity,
      'isActive': isActive,
      'description': description,
      'XS': xs,
      'M': m,
      'L': l,
      'XL': xl,
      'XXL': xxl,
      'imageUrl': imageUrl,
      'imagePublicId': imagePublicId,
      'category': category,
      'date': date,
      'time': time,
      'reviews': reviews,
    };
  }
}