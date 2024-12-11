import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/constant/environment.dart';

class DioConfig {

  static Dio configDio(){
    final dio = Dio(BaseOptions(
      baseUrl: Environment.API_URL,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 30000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));
    // TODO: Add interceptors
    // TODO: Add authentication token to headers
    // TODO: Handle errors
    // TODO: Add logging
    // TODO: Add response type
    // TODO: Add request type
    return dio;
  }
}