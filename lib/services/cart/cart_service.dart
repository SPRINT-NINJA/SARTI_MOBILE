import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  late final Dio dio;
  CartService() : dio = DioConfig.configDio();

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

  //update quantity of product in cart
  Future<bool> updateProductQuantity(int productId, int quantity) async {
    try {
      final response = await dio.put(
        '/cart',
        queryParameters: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating product quantity: $e');
      rethrow;
    }
  }

  //delete product from cart
  Future<bool> deleteProductFromCart(int catProductId ) async {
    try {
      final response = await dio.delete(
        '/cart/remove',
        queryParameters: {
          'catProductId': catProductId ,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error deleting product from cart: $e');
      rethrow;
    }
  }

  //clean cart
  Future<bool> cleanCart() async {
    try {
      final response = await dio.delete('/cart');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error cleaning cart: $e');
      rethrow;
    }
  }
}
