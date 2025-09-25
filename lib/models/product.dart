class Product {
  final int id;
  final String name;
  final String price;
  final String originalPrice;
  final String discount;
  final String imageUrl;
  final String category;
  final String description;
  final List<String> sizes;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.sizes,
    required this.rating,
    required this.reviewCount,
  });
}

class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
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

  double get totalPrice {
    // Remove currency symbol and convert to double
    String cleanPrice = product.price.replaceAll('₹', '').replaceAll(',', '');
    try {
      return double.parse(cleanPrice) * quantity;
    } catch (e) {
      return 0.0;
    }
  }
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
