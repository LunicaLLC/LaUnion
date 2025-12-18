import 'package:dio/dio.dart';
import '../models/menu_item.dart';
import '../models/order.dart';
import '../models/truck_location.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.launion.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<MenuItem>> getMenu() async {
    try {
      final response = await _dio.get('/api/menu');
      final data = response.data['data'] as List<dynamic>;
      return data.map((item) => MenuItem.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load menu: $e');
    }
  }

  Future<List<TruckLocation>> getCurrentLocations() async {
    try {
      final response = await _dio.get('/api/locations/current');
      final data = response.data['data'] as List<dynamic>;
      return data.map((loc) => TruckLocation.fromJson(loc)).toList();
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      final response = await _dio.post('/api/orders', data: order.toJson());
      return Order.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<Order> getOrderStatus(String orderId) async {
    try {
      final response = await _dio.get('/api/orders/$orderId/status');
      return Order.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get order status: $e');
    }
  }

  Future<bool> subscribeToNotifications(String phoneNumber) async {
    try {
      final response = await _dio.post(
        '/api/notifications',
        data: {'phone': phoneNumber},
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Failed to subscribe: $e');
    }
  }
}
