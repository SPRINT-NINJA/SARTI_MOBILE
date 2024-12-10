import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sarti_mobile/models/sellers/seller_model.dart';

class SellerService {
  final String baseUrl = "http://3.211.99.137:8081/api/sarti/seller/all";

  Future<PaginatedSellers> fetchSellers({
    required int page,
    int size = 1000,
    String sort = "name",
    String direction = "asc",
    String? searchValue,
  }) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {
      'page': page.toString(),
      'size': size.toString(),
      'sort': sort,
      'direction': direction,
      'searchValue': searchValue,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PaginatedSellers.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load sellers");
    }
  }
}
