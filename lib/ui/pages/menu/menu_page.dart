import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../config/theme.dart';
import '../../../models/menu_item.dart';
import '../../../providers/menu_provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../config/constants.dart';
import '../../widgets/menu_item_card.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(menuProvider.notifier).loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = ref.watch(menuProvider);
    final categories = [
      'All',
      ...ref.read(menuProvider.notifier).getCategories(),
    ];

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(AppConstants.lg),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchMenuHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        // Category filter
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.lg),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _selectedCategory == category;
              final displayText = category == 'All'
                  ? AppLocalizations.of(context)!.allCategories
                  : category;

              return Padding(
                padding: const EdgeInsets.only(right: AppConstants.sm),
                child: FilterChip(
                  label: Text(displayText),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : 'All';
                    });
                  },
                  backgroundColor: isSelected ? null : AppTheme.lightGrey,
                  selectedColor: AppTheme.spicyRed,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.charcoal,
                  ),
                ),
              );
            },
          ),
        ),
        // Menu items grid
        Expanded(
          child: menuItems.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : _buildMenuGrid(menuItems),
        ),
      ],
    );
  }

  Widget _buildMenuGrid(List<MenuItem> allItems) {
    List<MenuItem> filteredItems = allItems;

    // Apply category filter
    if (_selectedCategory != 'All') {
      filteredItems = filteredItems
          .where((item) => item.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where(
            (item) =>
                item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                item.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    if (filteredItems.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noItemsFound));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.lg,
        mainAxisSpacing: AppConstants.lg,
        childAspectRatio: 0.6,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return MenuItemCard(
          item: item,
          onTap: () => context.go('/menu/${item.id}'),
          onAddToCart: () {
            ref.read(cartProvider.notifier).addItem(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.addedToCart(item.name),
                ),
                backgroundColor: AppTheme.avocadoGreen,
              ),
            );
          },
        );
      },
    );
  }
}
