import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/services/product/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int currentPage = 0;
  int pageSize = 1000;
  String sortField = 'name';
  String sortDirection = 'asc';
  String searchValue = '';

  Future<void> fetchProducts({bool reset = false}) async {
    if (reset) {
      _products = [];
      currentPage = 0;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await _productService.fetchProducts(
        page: currentPage,
        size: pageSize,
        sort: sortField,
        direction: sortDirection,
        searchValue: searchValue,
      );

      if (reset) {
        _products = newProducts;
      } else {
        _products.addAll(newProducts);
      }

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
