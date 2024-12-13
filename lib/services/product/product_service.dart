import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';

class ProductService {
  late final Dio dio;
  ProductService() : dio = DioConfig.configDio();

  Future<List<Product>> fetchProducts({
    int page = 0,
    int size = 1000,
    String sort = 'name',
    String direction = 'asc',
    String searchValue = '',
  }) async {
    try {
      var sellerId = '';
      var prdName = '';
      final response = await dio.get(
        '/product',
        queryParameters: {
          'page': page,
          'size': size,
          'sort': sort,
          'direction': direction,
          'searchValue': searchValue,
          'productName': prdName,
          'sellerId': sellerId,
        },
      );

      if (response.statusCode == 200) {
        final List<Product> products = (response.data['data']['content'] as List).map((product) => Product.fromJson(product)).toList();
        return products;
      } else {
        throw Exception('Error al cargar los productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  //add product to cart

  Future<bool> addProductToCart(String productId) async {
    try {
      final response = await dio.post(
        '/cart',
        queryParameters: {
          'productId': productId,
          'quantity': 1,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}

