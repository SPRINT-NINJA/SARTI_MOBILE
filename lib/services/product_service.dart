import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';

class ProductService {
  late final Dio dio;

  ProductService() : dio = DioConfig.configDio();

  // Obtener lista de productos
  Future<List<Product>> fetchProducts({
    int page = 0,
    int size = 1000,
    String sort = 'name',
    String direction = 'asc',
    String searchValue = '',
  }) async {
    try {
      final response = await dio.get(
        '/product',
        queryParameters: {
          'page': page,
          'size': size,
          'sort': sort,
          'direction': direction,
          'searchValue': searchValue,
        },
      );

      if (response.statusCode == 200) {
        return (response.data['data']['content'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear producto
  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String mainImage,
    List<String>? additionalImages,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'mainImage': mainImage,
        'productImages': additionalImages ?? [],
      });

      final response = await dio.post('/product', data: formData);

      if (response.statusCode != 200) {
        throw Exception('Error al crear producto: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al crear producto: $e');
    }
  }

  // Obtener detalles de producto
  Future<Product> fetchProductDetails(int productId) async {
    try {
      final response = await dio.get('/product/$productId');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Error al obtener detalles: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al obtener detalles: $e');
    }
  }

  // Actualizar producto
  Future<void> updateProduct({
    required int productId,
    required String name,
    required String description,
    required double price,
    required int stock,
    String? mainImage,
    List<String>? additionalImages,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'id': productId,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'mainImage': mainImage,
        'productImages': additionalImages ?? [],
      });

      final response = await dio.put('/product', data: formData);

      if (response.statusCode != 200) {
        throw Exception(
            'Error al actualizar producto: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al actualizar producto: $e');
    }
  }

  // Actualizar stock
  Future<void> updateStock({
    required int productId,
    required int newStock,
  }) async {
    try {
      final response = await dio.patch(
        '/product',
        queryParameters: {
          'productId': productId,
          'newStock': newStock,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error al actualizar stock: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al actualizar stock: $e');
    }
  }

  // Eliminar producto
  Future<void> deleteProduct(int productId) async {
    try {
      final response = await dio.delete('/product/$productId');

      if (response.statusCode != 200) {
        throw Exception(
            'Error al eliminar producto: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al eliminar producto: $e');
    }
  }

  Future<void> changeProductStatus(int productId) async {
    try {
      final response = await dio.patch('/product/$productId');

      if (response.statusCode != 200) {
        throw Exception(
            'Error al cambiar el estado: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al cambiar el estado: $e');
    }
  }
}
