import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/services/product_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  Product? product;
  bool isLoading = false;

  Future<void> fetchProductDetails(int productId) async {
    try {
      isLoading = true;
      notifyListeners();

      product = await _productService.fetchProductDetails(productId);
    } catch (e) {
      debugPrint('Error al obtener detalles del producto: $e');
      throw Exception('Error al obtener detalles del producto');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
