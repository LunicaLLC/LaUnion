import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_item.dart';
import '../models/order_item.dart';

class CartItem {
  final MenuItem menuItem;
  final int quantity;
  final List<String> selectedModifiers;
  final String? specialInstructions;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
    this.selectedModifiers = const [],
    this.specialInstructions,
  });

  double get subtotal {
    double total = menuItem.price * quantity;
    for (var modifier in selectedModifiers) {
      final mod = menuItem.modifiers.firstWhere(
            (m) => m.name == modifier,
        orElse: () => MenuItemModifier(type: '', name: '', price: 0),
      );
      total += mod.price * quantity;
    }
    return total;
  }

  CartItem copyWith({
    int? quantity,
    List<String>? selectedModifiers,
    String? specialInstructions,
  }) {
    return CartItem(
      menuItem: menuItem,
      quantity: quantity ?? this.quantity,
      selectedModifiers: selectedModifiers ?? this.selectedModifiers,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(MenuItem menuItem, {int quantity = 1}) {
    final existingIndex = state.indexWhere(
          (item) => item.menuItem.id == menuItem.id,
    );

    if (existingIndex >= 0) {
      final existingItem = state[existingIndex];
      final newList = List<CartItem>.from(state);
      newList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      state = newList;
    } else {
      state = [...state, CartItem(menuItem: menuItem, quantity: quantity)];
    }
  }

  void removeItem(String menuItemId) {
    state = state.where((item) => item.menuItem.id != menuItemId).toList();
  }

  void updateQuantity(String menuItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(menuItemId);
      return;
    }

    final index = state.indexWhere((item) => item.menuItem.id == menuItemId);
    if (index >= 0) {
      final newList = List<CartItem>.from(state);
      newList[index] = state[index].copyWith(quantity: quantity);
      state = newList;
    }
  }

  void updateModifiers(String menuItemId, List<String> modifiers) {
    final index = state.indexWhere((item) => item.menuItem.id == menuItemId);
    if (index >= 0) {
      final newList = List<CartItem>.from(state);
      newList[index] = state[index].copyWith(selectedModifiers: modifiers);
      state = newList;
    }
  }

  void updateSpecialInstructions(String menuItemId, String instructions) {
    final index = state.indexWhere((item) => item.menuItem.id == menuItemId);
    if (index >= 0) {
      final newList = List<CartItem>.from(state);
      newList[index] = state[index].copyWith(specialInstructions: instructions);
      state = newList;
    }
  }

  void clearCart() {
    state = [];
  }

  double get subtotal {
    return state.fold(0, (sum, item) => sum + item.subtotal);
  }

  double get tax {
    return subtotal * 0.08; // 8% tax
  }

  double get total {
    return subtotal + tax;
  }

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }

  List<OrderItem> toOrderItems() {
    return state.map((cartItem) {
      return OrderItem(
        id: cartItem.menuItem.id,
        menuItemId: cartItem.menuItem.id,
        menuItemName: cartItem.menuItem.name,
        quantity: cartItem.quantity,
        price: cartItem.menuItem.price,
        modifiers: cartItem.selectedModifiers,
        specialInstructions: cartItem.specialInstructions,
      );
    }).toList();
  }
}