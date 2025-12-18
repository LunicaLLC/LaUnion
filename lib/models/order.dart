import 'order_item.dart';

class Order {
  final String id;
  final String userId;
  final OrderStatus status;
  final double total;
  final DateTime pickupTime;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.pickupTime,
    required this.paymentMethod,
    required this.createdAt,
    this.items = const [],
  });

  // Add this copyWith method
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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      status: OrderStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => OrderStatus.received,
      ),
      total: (json['total'] as num).toDouble(),
      pickupTime: DateTime.parse(json['pickup_time']),
      paymentMethod: PaymentMethod.values.firstWhere(
            (e) => e.name == json['payment_method'],
        orElse: () => PaymentMethod.card,
      ),
      createdAt: DateTime.parse(json['created_at']),
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status.name,
      'total': total,
      'pickup_time': pickupTime.toIso8601String(),
      'payment_method': paymentMethod.name,
      'created_at': createdAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

enum OrderStatus {
  received,
  preparing,
  ready,
  completed,
  cancelled,
}

enum PaymentMethod {
  card,
  cash,
  applePay,
  googlePay,
}