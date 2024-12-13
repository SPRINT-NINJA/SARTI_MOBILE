import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/services/product/product_service.dart';

class TopRatedProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 0;
  final int _pageSize = 10;
  String _sortDirection = 'desc';
  String get sortDirection => _sortDirection;

  bool _hasMore = true;

  Future<void> fetchTopRatedProducts({bool reset = false}) async {
    if (_isLoading) return;

    if (reset) {
      _products = [];
      _currentPage = 0;
      _hasMore = true;
    }

    if (!_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await _productService.fetchProducts(
        page: _currentPage,
        size: _pageSize,
        sort: 'rating',
        direction: _sortDirection,
      );

      if (newProducts.length < _pageSize) {
        _hasMore = false;
      }

      _products.addAll(newProducts);
      _errorMessage = null;
      _currentPage++;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSortOrder(String direction) {
    _sortDirection = direction;
    notifyListeners();
  }
}
