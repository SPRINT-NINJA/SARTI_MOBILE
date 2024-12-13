import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/network/dio_config.dart';
import 'package:sarti_mobile/models/product/product_model_public.dart';
import 'package:sarti_mobile/models/rate/rate_model.dart';

class RateService {
  final Dio _dio = DioConfig.configDio();

  Future<List<RateModel>> fetchRatedProducts({
    int page = 0,
    int size = 10,
    String sort = 'rate',
    String direction = 'desc',
  }) async {
    try {
      final response = await _dio.get(
        '/rate',
        queryParameters: {
          'page': page,
          'size': size,
          'sort': sort,
          'direction': direction,
        },
      );

      if (response.statusCode == 200) {
        return (response.data['data']['content'] as List)
            .map((item) => RateModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Error al cargar los productos ranqueados.');
      }
    } on DioError catch (e) {
      throw Exception('Error de red: ${e.message}');
    }
  }
}
