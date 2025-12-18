import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_item.dart';
import '../services/api_service.dart';
import '../models/order.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<Order>> {
  final _apiService = ApiService();

  OrderNotifier() : super([]);

  Future<Order> createOrder(Order order) async {
    try {
      // Mock order creation
      await Future.delayed(const Duration(seconds: 2));

      final newOrder = Order(
        id: 'order_${DateTime.now().millisecondsSinceEpoch}',
        userId: order.userId,
        status: OrderStatus.received,
        total: order.total,
        pickupTime: order.pickupTime,
        paymentMethod: order.paymentMethod,
        createdAt: DateTime.now(),
        items: order.items,
      );

      state = [newOrder, ...state];
      return newOrder;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> loadUserOrders(String userId) async {
    try {
      // Mock data
      await Future.delayed(const Duration(seconds: 1));

      state = [
        Order(
          id: 'order_001',
          userId: userId,
          status: OrderStatus.completed,
          total: 25.50,
          pickupTime: DateTime.now().subtract(const Duration(days: 1)),
          paymentMethod: PaymentMethod.card,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Order(
          id: 'order_002',
          userId: userId,
          status: OrderStatus.preparing,
          total: 18.75,
          pickupTime: DateTime.now().add(const Duration(minutes: 30)),
          paymentMethod: PaymentMethod.cash,
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<Order> getOrderById(String orderId) async {
    final order = state.firstWhere(
          (order) => order.id == orderId,
      orElse: () => throw Exception('Order not found'),
    );
    return order;
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final index = state.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      final newList = List<Order>.from(state);
      final updatedOrder = state[index].copyWith(status: status);
      newList[index] = updatedOrder;
      state = newList;
    }
  }

  Order? getActiveOrder() {
    return state.firstWhere(
          (order) => order.status != OrderStatus.completed && order.status != OrderStatus.cancelled,
      orElse: () => throw StateError('No active order'),
    );
  }
}

extension OrderCopyWith on Order {
  Order copyWith({
    String? id,
    String? userId,
    OrderStatus? status,
    double? total,
    DateTime? pickupTime,
    PaymentMethod? paymentMethod,
    DateTime? createdAt,
    List<OrderItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      total: total ?? this.total,
      pickupTime: pickupTime ?? this.pickupTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
    );
  }
}