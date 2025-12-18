class OrderItem {
  final String id;
  final String menuItemId;
  final String menuItemName;
  final int quantity;
  final double price;
  final List<String> modifiers;
  final String? specialInstructions;

  OrderItem({
    required this.id,
    required this.menuItemId,
    required this.menuItemName,
    required this.quantity,
    required this.price,
    this.modifiers = const [],
    this.specialInstructions,
  });

  double get subtotal => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      menuItemId: json['menu_item_id'],
      menuItemName: json['menu_item_name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      modifiers: List<String>.from(json['modifiers'] ?? []),
      specialInstructions: json['special_instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menu_item_id': menuItemId,
      'menu_item_name': menuItemName,
      'quantity': quantity,
      'price': price,
      'modifiers': modifiers,
      'special_instructions': specialInstructions,
    };
  }
}