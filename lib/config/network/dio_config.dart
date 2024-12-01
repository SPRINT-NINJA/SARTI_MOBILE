import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sarti_mobile/config/constant/environment.dart';

class DioConfig {
  static Dio createDio(BuildContext context) {
    final dio = Dio(BaseOptions(
      baseUrl: Environment.API_URL,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add authentication token to headers
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        // Handle errors
        if (error.response == null) {
          return handler.reject(DioException(
            requestOptions: error.requestOptions,
            response: Response(
              requestOptions: error.requestOptions,
              statusCode: 502,
              statusMessage: 'Network error',
              data: {'error': true, 'message': 'Network error', 'data': null, 'code': 502},
            ),
          ));
        }
        if (error.response?.statusCode == 401) {
          print('Unauthorized');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          prefs.remove('no_user');
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        } else if (error.response?.statusCode == 403) {
          print('Forbidden');
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
        return handler.next(error);
      },
    ));

    return dio;
  }
}