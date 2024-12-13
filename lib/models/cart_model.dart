class Cart {
  final int id;
  final double total;
  final String? createdAt;
  final String? updatedAt;
  final List<CartProduct>? cartProducts;

  Cart({
    required this.id,
    required this.total,
    this.createdAt,
    this.updatedAt,
    this.cartProducts,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      total: json['total'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'] ?? '',
      cartProducts: json['cartProducts'] != null ? (json['cartProducts'] as List).map((i) => CartProduct.fromJson(i)).toList() : null,
    );
  }
}

class Product {
  final int id;
  final String? name;
  final String? description;
  final String? mainImage;
  final double price;
  final int stock;
  final double rating;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;

  Product({
    required this.id,
    this.name,
    this.description,
    this.mainImage,
    required this.price,
    required this.stock,
    required this.rating,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      mainImage: json['mainImage'],
      price: json['price'],
      stock: json['stock'],
      rating: json['rating'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class CartProduct {
  final int id;
  final String? productInfo;
  final int amount;
  final double total;
  final bool? status;
  final Product? product;

  CartProduct({
    required this.id,
    this.productInfo,
    required this.amount,
    required this.total,
    this.status,
    this.product,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      productInfo: json['productInfo'],
      amount: json['amount'],
      total: json['total'],
      status: json['status'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}
