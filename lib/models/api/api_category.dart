class ApiCategory {
  final int id;
  final String categoryName;

  ApiCategory({
    required this.id,
    required this.categoryName,
  });

  factory ApiCategory.fromJson(Map<String, dynamic> json) {
    return ApiCategory(
      id: json['id'] as int,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
    };
  }
}