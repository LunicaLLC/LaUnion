import '../config/supabase_config.dart';
import '../models/order.dart';
import '../models/truck_location.dart';

class RealtimeService {
  final _client = SupabaseConfig.client;

  Stream<List<Order>> watchOrders() {
    return _client
        .from('orders')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((item) => Order.fromJson(item)).toList());
  }

  Stream<Order> watchOrder(String orderId) {
    return _client
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('id', orderId)
        .map(
          (data) => data.isNotEmpty
              ? Order.fromJson(data.first)
              : throw Exception('Order not found'),
        );
  }

  Stream<List<TruckLocation>> watchLocations() {
    return _client
        .from('truck_locations')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((loc) => TruckLocation.fromJson(loc)).toList());
  }
}
