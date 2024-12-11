import 'dio_client.dart';

class ApiGateway {
  final DioClient _client;

  ApiGateway(this._client);

  Future<dynamic> doGet(String endpoint) async {
    try {
      final response = await _client.dio.get(endpoint);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> doPost(String endpoint, dynamic data) async {
    try {
      final response = await _client.dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> doPut(String endpoint, dynamic data) async {
    try {
      final response = await _client.dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> doDelete(String endpoint) async {
    try {
      final response = await _client.dio.delete(endpoint);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
