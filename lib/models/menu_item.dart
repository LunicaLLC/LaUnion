class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String? imageUrl;
  final bool available;
  final List<MenuItemModifier> modifiers;
  final List<String> tags;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.available = true,
    this.modifiers = const [],
    this.tags = const [],
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: json['image_url'],
      available: json['available'] ?? true,
      modifiers: (json['modifiers'] as List<dynamic>?)
          ?.map((m) => MenuItemModifier.fromJson(m))
          .toList() ??
          [],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image_url': imageUrl,
      'available': available,
      'modifiers': modifiers.map((m) => m.toJson()).toList(),
      'tags': tags,
    };
  }
}

class MenuItemModifier {
  final String type;
  final String name;
  final double price;

  MenuItemModifier({
    required this.type,
    required this.name,
    required this.price,
  });

  factory MenuItemModifier.fromJson(Map<String, dynamic> json) {
    return MenuItemModifier(
      type: json['type'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'price': price,
    };
  }
}