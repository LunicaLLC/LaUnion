import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../models/menu_item.dart';

class AdminState {
  final List<Order> orders;
  final List<MenuItem> menuItems;
  final Map<String, dynamic> analytics;

  AdminState({
    this.orders = const [],
    this.menuItems = const [],
    this.analytics = const {},
  });

  AdminState copyWith({
    List<Order>? orders,
    List<MenuItem>? menuItems,
    Map<String, dynamic>? analytics,
  }) {
    return AdminState(
      orders: orders ?? this.orders,
      menuItems: menuItems ?? this.menuItems,
      analytics: analytics ?? this.analytics,
    );
  }
}

final adminProvider = StateNotifierProvider<AdminNotifier, AdminState>((ref) {
  return AdminNotifier();
});

class AdminNotifier extends StateNotifier<AdminState> {
  AdminNotifier() : super(AdminState());

  Future<void> loadOrders() async {
    try {
      // Mock data
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        orders: [
          Order(
            id: 'order_001',
            userId: 'user_001',
            status: OrderStatus.received,
            total: 25.50,
            pickupTime: DateTime.now().add(const Duration(minutes: 30)),
            paymentMethod: PaymentMethod.card,
            createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          ),
          Order(
            id: 'order_002',
            userId: 'user_002',
            status: OrderStatus.preparing,
            total: 18.75,
            pickupTime: DateTime.now().add(const Duration(minutes: 45)),
            paymentMethod: PaymentMethod.cash,
            createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<void> loadMenuItems() async {
    try {
      // Mock data - reuse menu items
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        menuItems: [
          MenuItem(
            id: 'pup-001',
            name: 'Pupusa Revuelta',
            description: 'Cheese, pork, beans',
            price: 3.50,
            category: 'Pupusas',
            available: true,
            imageUrl: 'assets/images/menu/PupusaRevuelta.webp',
          ),
          MenuItem(
            id: 'pup-002',
            name: 'Pupusa de Queso',
            description: 'Cheese only',
            price: 3.00,
            category: 'Pupusas',
            available: true,
            imageUrl: 'assets/images/menu/PupusaDeQueso.jpg',
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load menu items: $e');
    }
  }

  Future<void> loadAnalytics() async {
    try {
      // Mock analytics data
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        analytics: {
          'dailySales': 1250.75,
          'totalOrders': 42,
          'averageOrderValue': 29.78,
          'topItems': [
            {'name': 'Al Pastor Taco', 'count': 38},
            {'name': 'Pupusa Revuelta', 'count': 32},
            {'name': 'Horchata', 'count': 25},
          ],
          'busiestTimes': ['12:00-13:00', '18:00-19:00'],
          'loyaltySignups': 15,
        },
      );
    } catch (e) {
      throw Exception('Failed to load analytics: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final orders = List<Order>.from(state.orders);
    final index = orders.indexWhere((order) => order.id == orderId);

    if (index >= 0) {
      orders[index] = orders[index].copyWith(status: status);
      state = state.copyWith(orders: orders);
    }
  }

  Future<void> addMenuItem(MenuItem item) async {
    final menuItems = List<MenuItem>.from(state.menuItems);
    menuItems.add(item);
    state = state.copyWith(menuItems: menuItems);
  }

  Future<void> updateMenuItem(String itemId, MenuItem updatedItem) async {
    final menuItems = List<MenuItem>.from(state.menuItems);
    final index = menuItems.indexWhere((item) => item.id == itemId);

    if (index >= 0) {
      menuItems[index] = updatedItem;
      state = state.copyWith(menuItems: menuItems);
    }
  }

  Future<void> deleteMenuItem(String itemId) async {
    final menuItems = state.menuItems
        .where((item) => item.id != itemId)
        .toList();
    state = state.copyWith(menuItems: menuItems);
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return state.orders.where((order) => order.status == status).toList();
  }

  double getTotalSales() {
    return state.orders.fold(0, (sum, order) => sum + order.total);
  }

  int getOrderCountByStatus(OrderStatus status) {
    return state.orders.where((order) => order.status == status).length;
  }
}
