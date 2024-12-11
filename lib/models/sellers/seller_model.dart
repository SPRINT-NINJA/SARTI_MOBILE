class Seller {
  final int id;
  final String mainImage;
  final String name;
  final String description;

  Seller({
    required this.id,
    required this.mainImage,
    required this.name,
    required this.description,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      mainImage: json['mainImage'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class PaginatedSellers {
  final List<Seller> sellers;
  final int totalPages;

  PaginatedSellers({
    required this.sellers,
    required this.totalPages,
  });

  factory PaginatedSellers.fromJson(Map<String, dynamic> json) {
    return PaginatedSellers(
      sellers: (json['data']['content'] as List).map((e) => Seller.fromJson(e)).toList(),
      totalPages: json['data']['totalPages'],
    );
  }
}
