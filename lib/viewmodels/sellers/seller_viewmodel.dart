import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/sellers/seller_model.dart';
import 'package:sarti_mobile/services/sellers/seller_service.dart';

class SellersViewModel extends ChangeNotifier {
  final SellerService _sellerService = SellerService();
  List<Seller> _sellers = [];
  int _currentPage = 0;
  int _totalPages = 1;
  bool _isLoading = false;
  String? _searchValue;

  List<Seller> get sellers => _sellers;
  bool get isLoading => _isLoading;

  Future<void> loadSellers({bool isNextPage = false}) async {
    if (isNextPage && _currentPage >= _totalPages - 1) return;

    _isLoading = true;
    notifyListeners();

    if (!isNextPage) {
      _sellers = [];
      _currentPage = 0;
    }

    try {
      final response = await _sellerService.fetchSellers(
        page: _currentPage,
        searchValue: _searchValue,
      );
      _sellers.addAll(response.sellers);
      _totalPages = response.totalPages;
      _currentPage++;
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchValue(String value) {
    _searchValue = value;
    loadSellers();
  }
}
