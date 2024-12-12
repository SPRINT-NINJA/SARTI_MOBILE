import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late final Dio dio;
  AuthService() : dio = DioConfig.configDio();


  /// Check if email exists
  Future<String> checkEmailExists(String email) async {
    try {
      final response =
          await dio.get('/auth/user', queryParameters: {
        'email': email,
      });
      var name = '';

      if (response.statusCode == 200) {

        //use switch to chech what role is in response.data['data']['role'], and get the name according to the role
        switch (response.data['data']['role']) {
          case 'COMPRADOR':
            name = response.data['data']['customer']['name'] + ' ' + response.data['data']['customer']['fistLastName'] + ' ' + response.data['data']['customer']['secondLastName'];
            break;
          case 'EMPRENDEDOR':
            name = response.data['data']['seller']['name'] + ' ' + response.data['data']['seller']['fistLastName'] + ' ' + response.data['data']['seller']['secondLastName'];
            break;
          case 'REPARTIDOR':
            name = response.data['data']['deliveryMan']['name'] + ' ' + response.data['data']['deliveryMan']['fistLastName'] + ' ' + response.data['data']['deliveryMan']['secondLastName'];
            break;
        }
      }
      return name;
    } catch (e) {
      print('Error checking email: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var response = await dio.post(
        '/auth/sign-in',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['data'];
        final jwt = _decodeToken(token);
        await _saveUserSession(token);
        return {'error': response.data['error'], 'role': jwt.payload['role'][0]['authority']};
      }

      return {'error': response.data['error'], 'message': response.data['message']};

    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> sendCode(String email) async {
    try {
      final response = await dio.post(
        '/auth/send-code',
        data: {'email': email},
      );
      return response.data['error'];
    } catch (e) {
      print('Error sending code: $e');
      rethrow;
    }
  }

  Future<bool> recoveryPassword(String email, String code, String password) async {
    try {
      final response = await dio.post(
        '/auth/recovery-password',
        data: {'email': email, 'code': code, 'password': password},
      );
      return response.data['error'];
    } catch (e) {
      print('Error recovering password: $e');
      rethrow;
    }
  }

  Future<void> _saveUserSession(String Token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', Token);
    final jwt = _decodeToken(Token);
    await prefs.setString('role', jwt.payload['role'][0]['authority']);

    //decode token and save role in shared preferences

  }

  //decode jwt token
  JWT _decodeToken(String token) {
    final jwt = JWT.decode(token);
    return jwt;
  }
}
