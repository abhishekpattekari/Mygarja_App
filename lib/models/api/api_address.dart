class ApiAddress {
  final int id;
  final String street;
  final String city;
  final String landmark;
  final String pincode;
  final String address;

  ApiAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.landmark,
    required this.pincode,
    required this.address,
  });

  factory ApiAddress.fromJson(Map<String, dynamic> json) {
    return ApiAddress(
      id: json['id'] as int,
      street: json['steet'] as String, // Note: API uses "steet" instead of "street"
      city: json['city'] as String,
      landmark: json['landmark'] as String,
      pincode: json['pincode'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'steet': street,
      'city': city,
      'landmark': landmark,
      'pincode': pincode,
      'address': address,
    };
  }
}