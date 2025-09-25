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
