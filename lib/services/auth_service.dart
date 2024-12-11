import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late final Dio dio;
  AuthService() : dio = DioConfig.configDio();


  /// Check if email exists
  Future<bool> checkEmailExists(String email) async {
    try {
      final response =
          await dio.post('/auth/user', queryParameters: {
        'email': email,
      });

      if (response.statusCode == 200) {
        return response.data['exists'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking email: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/sign-in',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['data'];
        await _saveUserSession(token);
      }

      return response.data;
    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }

  Future<void> _saveUserSession(String Token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', Token);
  }

  //decode jwt token
  JWT _decodeToken(String token) {
    final jwt = JWT.decode(token);
    return jwt;
  }
}
