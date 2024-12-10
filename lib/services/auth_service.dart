import 'package:dio/dio.dart';

class AuthService {
  static final Dio _dio = Dio();

  // Replace with your actual backend URL
  static const String _baseUrl = 'http://localhost:8080/api/sarti';

  /// Check if email exists
  static Future<bool> checkEmailExists(String email) async {
    try {
      final response =
          await _dio.get('$_baseUrl/auth/check-email', queryParameters: {
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

  static Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }
}
