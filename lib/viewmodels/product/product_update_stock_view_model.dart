import 'package:flutter/material.dart';
import 'package:sarti_mobile/services/product_service.dart';

class UpdateStockViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  int stock = 0;
  bool isLoading = false;

  Future<void> updateStock(int productId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _productService.updateStock(
        productId: productId,
        newStock: stock,
      );
    } catch (e) {
      debugPrint('Error al actualizar stock: $e');
      throw Exception('Error al actualizar stock');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
