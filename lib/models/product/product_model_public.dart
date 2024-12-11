import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final String mainImage;
  final double price;
  final int stock;
  final double rating;
  final bool status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int sellerId;
  final List<String> productImages;
  final List<int> cartProductIds;
  final List<int> orderProductIds;
  final List<int> rateIds;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.mainImage,
    required this.price,
    required this.stock,
    required this.rating,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.sellerId,
    this.productImages = const [],
    this.cartProductIds = const [],
    this.orderProductIds = const [],
    this.rateIds = const [],
  });

  /// Factory para crear un objeto Product desde un JSON.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      mainImage: json['mainImage'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      rating: (json['rating'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      sellerId: json['seller']['id'],
      productImages: json['productImages'] != null
          ? List<String>.from(
              json['productImages'].map((image) => image['image']),
            )
          : [],
      rateIds: json['rates'] != null
          ? List<int>.from(json['rates'].map((rate) => rate['id']))
          : [],
    );
  }


  /// Método para convertir un objeto Product a JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'mainImage': mainImage,
      'price': price,
      'stock': stock,
      'rating': rating,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'seller': {'id': sellerId},
      'productImages': productImages.map((url) => {'url': url}).toList(),
      'cartProducts': cartProductIds.map((id) => {'id': id}).toList(),
      'orderProducts': orderProductIds.map((id) => {'id': id}).toList(),
      'rates': rateIds.map((id) => {'id': id}).toList(),
    };
  }
}
