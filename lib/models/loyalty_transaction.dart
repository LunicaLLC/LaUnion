class LoyaltyTransaction {
  final String id;
  final String userId;
  final int points;
  final LoyaltyTransactionType type;
  final String? orderId;
  final DateTime createdAt;

  LoyaltyTransaction({
    required this.id,
    required this.userId,
    required this.points,
    required this.type,
    this.orderId,
    required this.createdAt,
  });

  factory LoyaltyTransaction.fromJson(Map<String, dynamic> json) {
    return LoyaltyTransaction(
      id: json['id'],
      userId: json['user_id'],
      points: json['points'],
      type: LoyaltyTransactionType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => LoyaltyTransactionType.purchase,
      ),
      orderId: json['order_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'points': points,
      'type': type.name,
      'order_id': orderId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

enum LoyaltyTransactionType {
  purchase,
  referral,
  redemption,
  bonus,
}