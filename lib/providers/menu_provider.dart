import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_service.dart';
import '../models/menu_item.dart';

final menuProvider = StateNotifierProvider<MenuNotifier, List<MenuItem>>((ref) {
  return MenuNotifier();
});

class MenuNotifier extends StateNotifier<List<MenuItem>> {
  final _supabaseService = SupabaseService();

  MenuNotifier() : super([]);

  Future<void> loadMenu() async {
    try {
      // Mock data
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      state = [
        MenuItem(
          id: 'pup-001',
          name: 'Pupusa Revuelta',
          description: 'Cheese, pork, beans',
          price: 3.50,
          category: 'Pupusas',
          tags: ['spicy'],
          modifiers: [
            MenuItemModifier(type: 'extra', name: 'Extra Curtido', price: 0.50),
          ],
          imageUrl: 'assets/images/menu/PupusaRevuelta.webp',
        ),
        MenuItem(
          id: 'pup-002',
          name: 'Pupusa de Queso',
          description: 'Cheese only',
          price: 3.00,
          category: 'Pupusas',
          tags: ['vegetarian'],
          imageUrl: 'assets/images/menu/PupusaDeQueso.jpg',
        ),
        MenuItem(
          id: 'taco-001',
          name: 'Al Pastor Taco',
          description: 'Marinated pork, pineapple, onions, cilantro',
          price: 4.50,
          category: 'Tacos',
          tags: ['spicy'],
          imageUrl: 'assets/images/menu/tacos-al-pastor.jpg',
        ),
        MenuItem(
          id: 'taco-002',
          name: 'Carne Asada Taco',
          description: 'Grilled steak, onions, cilantro',
          price: 5.00,
          category: 'Tacos',
          tags: [],
          imageUrl: 'assets/images/menu/Carne-Asada-Tacos.jpg',
        ),
        MenuItem(
          id: 'other-001',
          name: 'Hot Dog',
          description:
              'Grilled hot dog with onions, ketchup, mustard, and mayo',
          price: 4.00,
          category: 'Specials',
          tags: [],
          imageUrl: 'assets/images/menu/hotdogs.jpg',
        ),
        MenuItem(
          id: 'side-001',
          name: 'Yuca Frita',
          description: 'Fried cassava served with curtido and salsa',
          price: 5.50,
          category: 'Sides',
          tags: ['vegetarian'],
          imageUrl: 'assets/images/menu/Yuca-Frita.jpg',
        ),
        MenuItem(
          id: 'drink-001',
          name: 'Horchata',
          description: 'Traditional rice drink with cinnamon',
          price: 3.50,
          category: 'Drinks',
          tags: [],
          imageUrl: 'assets/images/menu/horchata.jpg',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load menu: $e');
    }
  }

  List<MenuItem> getByCategory(String category) {
    return state.where((item) => item.category == category).toList();
  }

  List<String> getCategories() {
    return state.map((item) => item.category).toSet().toList();
  }

  List<MenuItem> search(String query) {
    if (query.isEmpty) return state;

    return state.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.description.toLowerCase().contains(query.toLowerCase()) ||
          item.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<MenuItem> filterByTag(String tag) {
    return state.where((item) => item.tags.contains(tag)).toList();
  }
}
