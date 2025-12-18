// import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../config/constants.dart';
import '../models/menu_item.dart';
import '../models/order.dart';
import '../models/truck_location.dart';
import '../models/app_user.dart';
import 'mock_data.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final _client = SupabaseConfig.client;

  // Users - now returns AppUser
  Future<AppUser?> getCurrentUser() async {
    if (AppConstants.useMockData) {
      final mockUser = MockData.currentUser;
      return AppUser(
        id: mockUser['id']!,
        email: mockUser['email']!,
        name: mockUser['full_name'],
        createdAt: DateTime.now().toIso8601String(),
        loyaltyPoints: 1250,
      );
    }

    final user = _client.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _client
          .from('users')
          .select()
          .eq('id', user.id)
          .single();
      return AppUser.fromJson(data);
    } catch (e) {
      // If user doesn't exist in users table, create a basic record
      return AppUser(
        id: user.id,
        email: user.email ?? '',
        name: user.userMetadata?['name'] as String?,
        phone: user.phone,
        createdAt: user.createdAt ?? DateTime.now().toIso8601String(),
        loyaltyPoints: 0,
      );
    }
  }

  // Menu
  Future<List<MenuItem>> getMenuItems() async {
    if (AppConstants.useMockData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return MockData.menuItems;
    }

    try {
      final data = await _client
          .from('menu_items')
          .select()
          .eq('available', true)
          .order('category');

      return (data as List<dynamic>)
          .map((item) => MenuItem.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load menu items: $e');
    }
  }

  // Orders
  Future<Order> createOrder(Order order) async {
    try {
      final data = await _client
          .from('orders')
          .insert(order.toJson())
          .select()
          .single();
      return Order.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Locations
  Future<List<TruckLocation>> getTruckLocations() async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockData.locations.map((loc) {
        return TruckLocation(
          id: loc['id'] as String,
          address: loc['name'] as String, // Using name as address for mock
          latitude: loc['latitude'] as double,
          longitude: loc['longitude'] as double,
          startTime: DateTime.now().subtract(const Duration(hours: 4)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
          dayOfWeek:
              DayOfWeek.values[DateTime.now().weekday - 1], // Current day
        );
      }).toList();
    }

    try {
      final data = await _client.from('truck_locations').select();

      return (data as List<dynamic>)
          .map((loc) => TruckLocation.fromJson(loc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load truck locations: $e');
    }
  }

  // Loyalty
  Future<int> getUserLoyaltyPoints(String userId) async {
    if (AppConstants.useMockData) {
      return 1250;
    }

    try {
      final data = await _client
          .from('users')
          .select('loyalty_points')
          .eq('id', userId)
          .single();

      return data['loyalty_points'] ?? 0;
    } catch (e) {
      return 0; // Return 0 if user not found
    }
  }

  // Get order by ID
  Future<Order> getOrderById(String orderId) async {
    try {
      final data = await _client
          .from('orders')
          .select()
          .eq('id', orderId)
          .single();
      return Order.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  // Get user orders
  Future<List<Order>> getUserOrders(String userId) async {
    try {
      final data = await _client
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (data as List<dynamic>)
          .map((item) => Order.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user orders: $e');
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _client.from('orders').update({'status': status}).eq('id', orderId);
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  // Real-time subscriptions
  Stream<List<Order>> subscribeToOrders() {
    return _client
        .from('orders')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((item) => Order.fromJson(item)).toList());
  }

  // Subscribe to real-time order updates
  Stream<Order> subscribeToOrder(String orderId) {
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

  // Sign in with email
  Future<AppUser?> signInWithEmail(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return await getCurrentUser();
      }
      return null;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Sign up - Fixed to work with newer Supabase API
  Future<AppUser?> signUp(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'phone': phone},
      );

      if (response.user != null) {
        // Create user record in users table
        await _client.from('users').insert({
          'id': response.user!.id,
          'email': email,
          'name': name,
          'phone': phone,
          'loyalty_points': 0,
          'created_at': DateTime.now().toIso8601String(),
        });

        return AppUser(
          id: response.user!.id,
          email: email,
          name: name,
          phone: phone,
          createdAt: DateTime.now()
              .toIso8601String(), // Fixed: String instead of DateTime
          loyaltyPoints: 0,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Update user profile
  Future<void> updateUserProfile(
    String userId,
    String name,
    String phone,
  ) async {
    try {
      await _client
          .from('users')
          .update({'name': name, 'phone': phone})
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Add loyalty points
  Future<void> addLoyaltyPoints(
    String userId,
    int points, {
    String? orderId,
  }) async {
    try {
      // First get current points
      final currentData = await _client
          .from('users')
          .select('loyalty_points')
          .eq('id', userId)
          .single();

      final currentPoints = currentData['loyalty_points'] ?? 0;
      final newPoints = currentPoints + points;

      // Update points
      await _client
          .from('users')
          .update({'loyalty_points': newPoints})
          .eq('id', userId);

      // Create loyalty transaction record
      await _client.from('loyalty_transactions').insert({
        'user_id': userId,
        'points': points,
        'type': 'purchase',
        'order_id': orderId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to add loyalty points: $e');
    }
  }

  // Get loyalty transactions
  Future<List<Map<String, dynamic>>> getLoyaltyTransactions(
    String userId,
  ) async {
    try {
      final data = await _client
          .from('loyalty_transactions')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (data as List<dynamic>).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to get loyalty transactions: $e');
    }
  }

  // Get today's truck locations
  Future<List<TruckLocation>> getTodaysLocations() async {
    if (AppConstants.useMockData) {
      // Return current mock location as today's location
      return MockData.locations.map((loc) {
        return TruckLocation(
          id: loc['id'] as String,
          address: loc['name'] as String,
          latitude: loc['latitude'] as double,
          longitude: loc['longitude'] as double,
          startTime: DateTime.now().subtract(const Duration(hours: 4)),
          endTime: DateTime.now().add(const Duration(hours: 4)),
          dayOfWeek: DayOfWeek.values[DateTime.now().weekday - 1],
        );
      }).toList();
    }

    try {
      final now = DateTime.now();
      final dayOfWeek = now.weekday - 1; // 0 = Monday, 6 = Sunday

      final data = await _client
          .from('truck_locations')
          .select()
          .eq('day_of_week', dayOfWeek);

      return (data as List<dynamic>)
          .map((loc) => TruckLocation.fromJson(loc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get today\'s locations: $e');
    }
  }

  // Search menu items
  Future<List<MenuItem>> searchMenuItems(String query) async {
    try {
      final data = await _client
          .from('menu_items')
          .select()
          .ilike('name', '%$query%')
          .eq('available', true);

      return (data as List<dynamic>)
          .map((item) => MenuItem.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to search menu items: $e');
    }
  }
}
