import 'package:flutter/material.dart';
import 'package:sarti_mobile/services/product_service.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int _currentPage = 0;
  final int _pageSize = 10;
  String _searchQuery = '';

  ProductListViewModel() {
    fetchProducts();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 0;
    products.clear();
    hasMore = true;
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final fetchedProducts = await _productService.fetchProducts(
        page: _currentPage,
        size: _pageSize,
        searchValue: _searchQuery,
      );

      if (fetchedProducts.length < _pageSize) {
        hasMore = false;
      }

      products.addAll(fetchedProducts);
      _currentPage++;
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _productService.deleteProduct(productId);
      products.removeWhere((product) => product.id == productId);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> changeProductStatus(int productId) async {
    try {
      // Simular cambio de estado
      final productIndex =
          products.indexWhere((product) => product.id == productId);

      if (productIndex != -1) {
        final currentProduct = products[productIndex];
        final updatedProduct = Product(
          id: currentProduct.id,
          name: currentProduct.name,
          description: currentProduct.description,
          mainImage: currentProduct.mainImage,
          price: currentProduct.price,
          stock: currentProduct.stock,
          rating: currentProduct.rating,
          status: !currentProduct.status,
          createdAt: currentProduct.createdAt,
          updatedAt: currentProduct.updatedAt,
          sellerId: currentProduct.sellerId,
          productImages: currentProduct.productImages,
          cartProductIds: currentProduct.cartProductIds,
          orderProductIds: currentProduct.orderProductIds,
          rateIds: currentProduct.rateIds,
        );

        products[productIndex] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error changing product status: $e');
    }
  }

  void loadMoreProducts() {
    if (hasMore) {
      fetchProducts();
    }
  }
}
