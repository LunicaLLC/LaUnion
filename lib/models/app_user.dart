class AppUser {
  final String id;
  final String email;
  final String? phone;
  final String? name;
  final int loyaltyPoints;
  final String? referralCode;
  final String createdAt;

  AppUser({
    required this.id,
    required this.email,
    this.phone,
    this.name,
    required this.createdAt,
    this.loyaltyPoints = 0,
    this.referralCode,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      loyaltyPoints: json['loyalty_points'] ?? 0,
      referralCode: json['referral_code'],
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'loyalty_points': loyaltyPoints,
      'referral_code': referralCode,
      'created_at': createdAt,
    };
  }
}