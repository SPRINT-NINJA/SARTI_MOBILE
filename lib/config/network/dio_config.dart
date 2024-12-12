import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/constant/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve token from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null && token.isNotEmpty) {
          // Add Authorization header
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // Continue with the request
      },
      onError: (DioError error, handler) {
        // Handle errors globally
        print('Dio Error: ${error.message}');
        return handler.next(error); // Continue error propagation
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