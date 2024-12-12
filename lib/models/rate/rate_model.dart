import 'package:sarti_mobile/models/product/product_model_public.dart';

class RateModel {
  final int id;
  final String customerName;
  final int rate; // La calificación individual
  final String comment;
  final String image;
  final bool status;
  final DateTime createdAt;
  final Product? product; // Producto con rating incluido

  RateModel({
    required this.id,
    required this.customerName,
    required this.rate,
    required this.comment,
    required this.image,
    required this.status,
    required this.createdAt,
    this.product,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      customerName: json['customerName'],
      rate: json['rate'], // Calificación de la reseña
      comment: json['comment'],
      image: json['image'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null, // Producto asociado
    );
  }
}
