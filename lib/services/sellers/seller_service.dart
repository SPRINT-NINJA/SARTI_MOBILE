import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/sellers/seller_model.dart';

class SellerService {
  late final Dio dio;
  SellerService() : dio = DioConfig.configDio();

  Future<PaginatedSellers> fetchSellers({
    required int page,
    int size = 1000,
    String sort = "name",
    String direction = "asc",
    String? searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/seller/all',
        queryParameters: {
          'page': page,
          'size': size,
          'sort': sort,
          'direction': direction,
          'searchValue': searchValue,
        },
      );
      if (response.statusCode == 200) {
        return PaginatedSellers.fromJson(response.data);
      } else {
        throw Exception("Failed to load sellers");
      }
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }
}
