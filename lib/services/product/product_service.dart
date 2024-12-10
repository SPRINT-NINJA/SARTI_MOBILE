import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sarti_mobile/models/product/product_model_public.dart';

class ProductService {
  final String baseUrl = 'http://3.211.99.137:8081/api/sarti/product';

  Future<List<Product>> fetchProducts({
    int page = 0,
    int size = 1000,
    String sort = 'name',
    String direction = 'asc',
    String searchValue = '',
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl?page=$page&size=$size&sort=$sort,$direction&searchValue=$searchValue',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final List<dynamic> productsData = decodedResponse['data']['content'];

        return productsData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar los productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}

