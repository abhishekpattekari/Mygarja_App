class ApiWishlistItem {
  final int wishlistId;
  final int productId;
  final String productName;
  final String productImage;
  final String productPrice;

  ApiWishlistItem({
    required this.wishlistId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  factory ApiWishlistItem.fromJson(Map<String, dynamic> json) {
    return ApiWishlistItem(
      wishlistId: json['wishlistId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: json['productPrice'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wishlistId': wishlistId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
    };
  }
}