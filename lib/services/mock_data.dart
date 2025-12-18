import '../models/menu_item.dart';

class MockData {
  static final List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      name: 'Pupusa Revuelta',
      description:
          'Traditional corn tortilla stuffed with pork, cheese, and beans.',
      price: 3.50,
      category: 'Pupusas',
      imageUrl: 'assets/images/menu/PupusaRevuelta.webp',
      available: true,
    ),
    MenuItem(
      id: '2',
      name: 'Pupusa de Queso',
      description: 'Cheese-stuffed corn tortilla.',
      price: 3.50,
      category: 'Pupusas',
      imageUrl: 'assets/images/menu/PupusaDeQueso.jpg',
      available: true,
    ),
    MenuItem(
      id: '3',
      name: 'Carne Asada Taco',
      description: 'Grilled steak taco with onions and cilantro.',
      price: 3.00,
      category: 'Tacos',
      imageUrl: 'assets/images/menu/Carne-Asada-Tacos.jpg',
      available: true,
    ),
    MenuItem(
      id: '4',
      name: 'Al Pastor Taco',
      description: 'Marinated pork taco with pineapple.',
      price: 3.00,
      category: 'Tacos',
      imageUrl: 'assets/images/menu/tacos-al-pastor.jpg',
      available: true,
    ),
    MenuItem(
      id: '5',
      name: 'Hot Dog',
      description: 'Classic hot dog.',
      price: 4.00,
      category: 'Fast Food',
      imageUrl: 'assets/images/menu/hotdogs.jpg',
      available: true,
    ),
    MenuItem(
      id: '6',
      name: 'Yuca Frita',
      description: 'Fried cassava served with salsa and curtido.',
      price: 5.00,
      category: 'Sides',
      imageUrl: 'assets/images/menu/Yuca-Frita.jpg',
      available: true,
    ),
    MenuItem(
      id: '7',
      name: 'Horchata',
      description: 'Sweet rice beverage.',
      price: 2.50,
      category: 'Drinks',
      imageUrl: 'assets/images/menu/horchata.jpg',
      available: true,
    ),
  ];

  static const currentUser = {
    'id': 'user_123',
    'email': 'user@example.com',
    'full_name': 'John Doe',
  };

  static final List<Map<String, dynamic>> locations = [
    {
      'id': 'loc_1',
      'name': 'Downtown Plaza',
      'latitude': 34.0522,
      'longitude': -118.2437,
      'is_active': true,
      'departure_time': DateTime.now()
          .add(const Duration(hours: 2))
          .toIso8601String(),
    },
  ];
}
