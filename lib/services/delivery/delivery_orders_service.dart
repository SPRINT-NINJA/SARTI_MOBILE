import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryOrdersService {
  late final Dio dio;
  DeliveryOrdersService() : dio = DioConfig.configDio();

  Future<List<OrderDelivery>> getOrders() async {
    try {
      final response = await dio.get('/order-delivery/to-take');

      return (response.data['data']['content'] as List)
          .map((order) => OrderDelivery.fromJson(order))
          .toList();
    } catch (e) {
      print('Error getting orders: $e');
      rethrow;
    }
  }

  //taked orders
  Future<List<OrderDelivery>> getTakedOrders() async {
    try {
      final response = await dio.get('/order-delivery/taken');

      return (response.data['data'] as List)
          .map((order) => OrderDelivery.fromJson(order))
          .toList();
    } catch (e) {
      print('Error getting orders: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    try {
      final response = await dio.get('/delivery/orders/$orderId');

      if (response.statusCode == 200) {
        return response.data;
      }

      return {'error': response.data['error'], 'message': response.data['message']};
    } catch (e) {
      print('Error getting order detail: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> acceptOrder(String orderId) async {
    try {
      final response = await dio.post('/delivery/orders/$orderId/accept');

      if (response.statusCode == 200) {
        return response.data;
      }

      return {'error': response.data['error'], 'message': response.data['message']};
    } catch (e) {
      print('Error accepting order: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> rejectOrder(String orderId) async {
    try {
      final response = await dio.post('/delivery/orders/$orderId/reject');

      if (response.statusCode == 200) {
        return response.data;
      }

      return {'error': response.data['error'], 'message': response.data['message']};
    } catch (e) {
      print('Error rejecting order: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> completeOrder(String orderId) async {
    try {
      final response = await dio.post('/delivery/orders/$orderId/complete');

      if (response.statusCode == 200) {
        return response.data;
      }

      return {'error': response.data['error'], 'message': response.data['message']};
    } catch (e) {
      print('Error completing order: $e');
      rethrow;
    }
  }
}