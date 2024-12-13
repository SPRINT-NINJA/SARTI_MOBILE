import 'package:flutter/material.dart';
import 'package:sarti_mobile/services/product_service.dart';

class ProductUpdateViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  String name = "";
  String description = "";
  double price = 0.0;
  int stock = 0;
  String? mainImage;
  List<String>? additionalImages;

  bool isLoading = false;

  Future<void> updateProduct(int productId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _productService.updateProduct(
        productId: productId,
        name: name,
        description: description,
        price: price,
        stock: stock,
        mainImage: mainImage,
        additionalImages: additionalImages,
      );
    } catch (e) {
      debugPrint('Error al actualizar producto: $e');
      throw Exception('Error al actualizar producto');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
