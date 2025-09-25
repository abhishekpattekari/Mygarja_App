import '../models/product.dart';
import '../models/user.dart';

class DummyData {
  // Dummy Categories
  static List<Category> categories = [
    Category(
      id: 1,
      name: "T-Shirts",
      imageUrl: "https://via.placeholder.com/150x150/FF6B6B/FFFFFF?text=T-Shirt",
    ),
    Category(
      id: 2,
      name: "Jeans",
      imageUrl: "https://via.placeholder.com/150x150/4ECDC4/FFFFFF?text=Jeans",
    ),
    Category(
      id: 3,
      name: "Shoes",
      imageUrl: "https://via.placeholder.com/150x150/45B7D1/FFFFFF?text=Shoes",
    ),
    Category(
      id: 4,
      name: "Jackets",
      imageUrl: "https://via.placeholder.com/150x150/F7DC6F/FFFFFF?text=Jacket",
    ),
    Category(
      id: 5,
      name: "Accessories",
      imageUrl: "https://via.placeholder.com/150x150/BB8FCE/FFFFFF?text=Access",
    ),
  ];

  // Dummy Products
  static List<Product> products = [
    Product(
      id: 1,
      name: "Classic White T-Shirt",
      price: "₹499",
      originalPrice: "₹799",
      discount: "38% OFF",
      imageUrl: "https://via.placeholder.com/300x400/FF6B6B/FFFFFF?text=White+T-Shirt",
      category: "T-Shirts",
      description: "Comfortable cotton t-shirt perfect for everyday wear. Made from 100% premium cotton.",
      sizes: ["XS", "S", "M", "L", "XL", "XXL"],
      rating: 4.5,
      reviewCount: 128,
    ),
    Product(
      id: 2,
      name: "Slim Fit Blue Jeans",
      price: "₹1,299",
      originalPrice: "₹1,999",
      discount: "35% OFF",
      imageUrl: "https://via.placeholder.com/300x400/4ECDC4/FFFFFF?text=Blue+Jeans",
      category: "Jeans",
      description: "Stylish slim fit jeans with premium denim fabric. Perfect for casual and semi-formal occasions.",
      sizes: ["28", "30", "32", "34", "36", "38"],
      rating: 4.3,
      reviewCount: 89,
    ),
    Product(
      id: 3,
      name: "Running Sneakers",
      price: "₹2,499",
      originalPrice: "₹3,999",
      discount: "38% OFF",
      imageUrl: "https://via.placeholder.com/300x400/45B7D1/FFFFFF?text=Sneakers",
      category: "Shoes",
      description: "Lightweight running shoes with excellent cushioning and breathable mesh upper.",
      sizes: ["6", "7", "8", "9", "10", "11"],
      rating: 4.7,
      reviewCount: 256,
    ),
    Product(
      id: 4,
      name: "Leather Jacket",
      price: "₹3,999",
      originalPrice: "₹6,999",
      discount: "43% OFF",
      imageUrl: "https://via.placeholder.com/300x400/F7DC6F/FFFFFF?text=Leather+Jacket",
      category: "Jackets",
      description: "Premium leather jacket with modern design. Perfect for winter and style statement.",
      sizes: ["S", "M", "L", "XL", "XXL"],
      rating: 4.6,
      reviewCount: 67,
    ),
    Product(
      id: 5,
      name: "Casual Watch",
      price: "₹1,999",
      originalPrice: "₹2,999",
      discount: "33% OFF",
      imageUrl: "https://via.placeholder.com/300x400/BB8FCE/FFFFFF?text=Watch",
      category: "Accessories",
      description: "Elegant casual watch with stainless steel strap. Water resistant and durable.",
      sizes: ["One Size"],
      rating: 4.4,
      reviewCount: 143,
    ),
    Product(
      id: 6,
      name: "Black Polo Shirt",
      price: "₹699",
      originalPrice: "₹1,199",
      discount: "42% OFF",
      imageUrl: "https://via.placeholder.com/300x400/2C3E50/FFFFFF?text=Polo+Shirt",
      category: "T-Shirts",
      description: "Classic black polo shirt made from premium cotton blend. Perfect for office and casual wear.",
      sizes: ["S", "M", "L", "XL", "XXL"],
      rating: 4.2,
      reviewCount: 94,
    ),
    Product(
      id: 7,
      name: "Cargo Pants",
      price: "₹1,599",
      originalPrice: "₹2,299",
      discount: "30% OFF",
      imageUrl: "https://via.placeholder.com/300x400/E67E22/FFFFFF?text=Cargo+Pants",
      category: "Jeans",
      description: "Comfortable cargo pants with multiple pockets. Made from durable cotton fabric.",
      sizes: ["28", "30", "32", "34", "36"],
      rating: 4.1,
      reviewCount: 76,
    ),
    Product(
      id: 8,
      name: "Canvas Shoes",
      price: "₹1,299",
      originalPrice: "₹1,899",
      discount: "32% OFF",
      imageUrl: "https://via.placeholder.com/300x400/27AE60/FFFFFF?text=Canvas+Shoes",
      category: "Shoes",
      description: "Comfortable canvas shoes perfect for casual outings. Lightweight and breathable.",
      sizes: ["6", "7", "8", "9", "10"],
      rating: 4.0,
      reviewCount: 112,
    ),
  ];

  // Dummy User
  static User currentUser = User(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    phoneNumber: "+91 9876543210",
    profileImageUrl: "https://via.placeholder.com/150x150/3498DB/FFFFFF?text=JD",
  );

  // Dummy Cart Items
  static List<CartItem> cartItems = [
    CartItem(
      product: products[0], // White T-Shirt
      quantity: 2,
      selectedSize: "M",
    ),
    CartItem(
      product: products[2], // Running Sneakers
      quantity: 1,
      selectedSize: "9",
    ),
  ];

  // Dummy Orders
  static List<Order> orders = [
    Order(
      id: 1001,
      items: [
        CartItem(
          product: products[1], // Blue Jeans
          quantity: 1,
          selectedSize: "32",
        ),
        CartItem(
          product: products[4], // Watch
          quantity: 1,
          selectedSize: "One Size",
        ),
      ],
      totalAmount: 3298.0,
      status: "Delivered",
      orderDate: DateTime.now().subtract(Duration(days: 5)),
      shippingAddress: "123 Main Street, City, State - 123456",
    ),
    Order(
      id: 1002,
      items: [
        CartItem(
          product: products[3], // Leather Jacket
          quantity: 1,
          selectedSize: "L",
        ),
      ],
      totalAmount: 3999.0,
      status: "In Transit",
      orderDate: DateTime.now().subtract(Duration(days: 2)),
      shippingAddress: "123 Main Street, City, State - 123456",
    ),
  ];

  // Helper methods
  static List<Product> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }

  static List<Product> getLatestProducts() {
    return products.take(4).toList();
  }

  static Product? getProductById(int id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  static double getCartTotal() {
    return cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

  static int getCartItemCount() {
    return cartItems.fold(0, (total, item) => total + item.quantity);
  }
}
