class Modifier {
  final String id;
  final String name;
  final String type; // 'extra', 'choice', 'option'
  final double price;
  final bool isAvailable;

  Modifier({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.isAvailable = true,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) {
    return Modifier(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      price: (json['price'] as num).toDouble(),
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'price': price,
      'is_available': isAvailable,
    };
  }
}