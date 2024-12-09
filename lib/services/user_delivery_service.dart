import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/mappers/user_delivery_mapper.dart';
import 'package:sarti_mobile/models/models.dart';


final userDeliveryServiceProvider  = Provider<UserDeliveryService>((ref) {
  return UserDeliveryService();
});


class UserDeliveryService {

  late final Dio dio;

  UserDeliveryService() : dio = DioConfig.configDio();

  Future<UserDelivery> createUserDelivery(Map<String, dynamic> userDeliveryLike) async {
    final response = await dio.post('/user-delivery', data: userDeliveryLike);
    final UserDelivery userDelivery = UserDeliveryMapper.jsonToModel(response.data);
    return userDelivery;
  }
}