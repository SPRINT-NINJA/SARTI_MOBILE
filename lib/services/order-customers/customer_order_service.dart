import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/cart_model.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOrderService {
  late final Dio dio;
  CustomerOrderService() : dio = DioConfig.configDio();

  //get car from logged COMPRADOR
  Future<Cart> getCart() async {
    try {
      final response = await dio.get('/cart');
      if (response.statusCode == 200) {
        return Cart.fromJson(response.data['data']);
      }else{
        throw Exception('Error al cargar el carrito: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting cart: $e');
      rethrow;
    }
  }

  //get orders from logged COMPRADOR
  Future<List<OrderDelivery>> getOrders(String searchValue, String step, String type, {
      int page = 0,
      int size = 1000,
      String sort = 'id',
      String direction = 'asc',
    }) async {
    try {
      //send paramethers and a paggeable by query
      final response = await dio.get('/order-delivery/history', queryParameters: {
        'page': page,
        'size': size,
        'sort': sort,
        'direction': direction,
      });
      if (response.statusCode == 200) {
        return (response.data['data']['content'] as List)
            .map((order) => OrderDelivery.fromJson(order))
            .toList();
      } else {
        throw Exception('Error al cargar las ordenes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting orders: $e');
      rethrow;
    }
  }
}
