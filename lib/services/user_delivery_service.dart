import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/config/config.dart';


final userDeliveryServiceProvider = Provider<UserDeliveryService>((ref) {
  return UserDeliveryService();
});


class UserDeliveryService {

  late final Dio dio;

  UserDeliveryService() : dio = DioConfig.configDio();

  Future<String> createUserDelivery(
      Map<String, dynamic> userDeliveryLike) async {
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
            userDeliveryLike['frontIdentification']?? ''),
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

      return customResponse['error'] ? 'Error' :  customResponse['data'];
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

}