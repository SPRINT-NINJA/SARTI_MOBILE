import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/services/product/product_service.dart';



part 'product_provider.g.dart';


@riverpod
Future<List<Product>> getSellProducts(GetSellProductsRef ref) async {

  final ProductService _productService = ProductService();


  final newProducts = await _productService.fetchProducts(
    page: 0,
    size: 10,
    sort: 'name',
    direction: 'asc',
    searchValue: '',
  );



  return newProducts;
}