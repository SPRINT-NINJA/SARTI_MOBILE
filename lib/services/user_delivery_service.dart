import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/config/config.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  late final Dio dio;

  AuthService() : dio = DioConfig.configDio();

  Future<String> createUserSeller(Map<String, dynamic> userSellerLike) async {
    try {
      final response =
          await dio.post('/seller/signup', data: userSellerLike);

      final customResponse = {
        "data": response.data['data'],
        "status": response.data['status'],
        "message": response.data['message'],
        "error": response.data['error'],
      };

      return customResponse['error'] ? 'Error' : customResponse['data'];
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> createUserCostumer(Map<String, dynamic> userCostumerLike) async {
    try {
      final response =
          await dio.post('/costumer/signup', data: userCostumerLike);

      final customResponse = {
        "data": response.data['data'],
        "status": response.data['status'],
        "message": response.data['message'],
        "error": response.data['error'],
      };

      return customResponse['error'] ? 'Error' : customResponse['data'];
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> createUserDelivery(Map<String, dynamic> userDeliveryLike) async {
    try {
      final FormData formData = FormData.fromMap({
        "email": userDeliveryLike['email'] ?? '',
        "password": userDeliveryLike['password'] ?? '',
        "name": userDeliveryLike['name'] ?? '',
        "firstLastName": userDeliveryLike['firstLastName'] ?? '',
        "secondLastName": userDeliveryLike['secondLastName'] ?? '',
        "profilePicture": MultipartFile.fromFileSync(
            userDeliveryLike['profilePicture'] ?? ''),
        "frontIdentification": MultipartFile.fromFileSync(
            userDeliveryLike['frontIdentification'] ?? ''),
        "backIdentification": MultipartFile.fromFileSync(
            userDeliveryLike['backIdentification'] ?? ''),
      });

      final response = await dio.post('/delivery-man/signup', data: formData);
      final customResponse = {
        "data": response.data['data'],
        "status": response.data['status'],
        "message": response.data['message'],
        "error": response.data['error'],
      };

      return customResponse['error'] ? 'Error' : customResponse['data'];
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
