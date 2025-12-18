import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/menu_item.dart';
import '../../../providers/admin_provider.dart';
import '../../../ui/layout/admin_scaffold.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';

class AdminMenuPage extends ConsumerStatefulWidget {
  const AdminMenuPage({super.key});

  @override
  ConsumerState<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends ConsumerState<AdminMenuPage> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminProvider.notifier).loadMenuItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = ref.watch(adminProvider).menuItems;
    final categories = _getCategories(menuItems);

    return AdminScaffold(
      title: 'Menu Management',
      actions: [
        IconButton(onPressed: _addMenuItem, icon: const Icon(Icons.add)),
      ],
      child: Column(
        children: [
          // Search and filter
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search menu items...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: ['All', ...categories].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value!);
                  },
                ),
              ],
            ),
          ),
          // Menu items grid
          Expanded(child: _buildMenuGrid(menuItems)),
        ],
      ),
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
    final searchQuery = _searchController.text;
    if (searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where(
            (item) =>
                item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                item.description.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No menu items found'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.lg,
        mainAxisSpacing: AppConstants.lg,
        childAspectRatio: 0.9,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildMenuItemCard(item);
      },
    );
  }

  Widget _buildMenuItemCard(MenuItem item) {
    return AppCard(
      onTap: () => _editMenuItem(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppTheme.lightGrey,
              image: item.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: item.imageUrl == null
                ? Center(
                    child: Icon(
                      Icons.fastfood,
                      size: 48,
                      color: AppTheme.charcoal.withOpacity(0.3),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Switch(
                value: item.available,
                onChanged: (value) {
                  _toggleAvailability(item.id, value);
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppConstants.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(item.category),
                backgroundColor: AppTheme.lightGrey,
                labelStyle: const TextStyle(fontSize: 12),
              ),
              Text(
                Formatters.formatCurrency(item.price),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.spicyRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _editMenuItem(item),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: AppConstants.sm),
              IconButton(
                onPressed: () => _deleteMenuItem(item.id),
                icon: const Icon(Icons.delete),
                color: AppTheme.spicyRed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> _getCategories(List<MenuItem> items) {
    return items.map((item) => item.category).toSet().toList();
  }

  void _addMenuItem() {
    showDialog(
      context: context,
      builder: (context) => _MenuItemDialog(
        onSave: (item) {
          ref.read(adminProvider.notifier).addMenuItem(item);
        },
      ),
    );
  }

  void _editMenuItem(MenuItem item) {
    showDialog(
      context: context,
      builder: (context) => _MenuItemDialog(
        item: item,
        onSave: (updatedItem) {
          ref.read(adminProvider.notifier).updateMenuItem(item.id, updatedItem);
        },
      ),
    );
  }

  void _deleteMenuItem(String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this menu item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(adminProvider.notifier).deleteMenuItem(itemId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Menu item deleted'),
                  backgroundColor: AppTheme.avocadoGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.spicyRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleAvailability(String itemId, bool available) {
    final items = ref.read(adminProvider).menuItems;
    final item = items.firstWhere((i) => i.id == itemId);
    final updatedItem = MenuItem(
      id: item.id,
      name: item.name,
      description: item.description,
      price: item.price,
      category: item.category,
      imageUrl: item.imageUrl,
      available: available,
      modifiers: item.modifiers,
      tags: item.tags,
    );

    ref.read(adminProvider.notifier).updateMenuItem(itemId, updatedItem);
  }
}

class _MenuItemDialog extends StatefulWidget {
  final MenuItem? item;
  final Function(MenuItem) onSave;

  const _MenuItemDialog({this.item, required this.onSave});

  @override
  State<_MenuItemDialog> createState() => _MenuItemDialogState();
}

class _MenuItemDialogState extends State<_MenuItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();
  bool _available = true;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _descriptionController.text = widget.item!.description;
      _priceController.text = widget.item!.price.toString();
      _categoryController.text = widget.item!.category;
      _imageUrlController.text = widget.item!.imageUrl ?? '';
      _available = widget.item!.available;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add Menu Item' : 'Edit Menu Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.md),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppConstants.md),
              Row(
                children: [
                  const Text('Available'),
                  const Spacer(),
                  Switch(
                    value: _available,
                    onChanged: (value) {
                      setState(() => _available = value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveItem, child: const Text('Save')),
      ],
    );
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final item = MenuItem(
        id: widget.item?.id ?? 'item_${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        category: _categoryController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : null,
        available: _available,
        modifiers: widget.item?.modifiers ?? [],
        tags: widget.item?.tags ?? [],
      );

      widget.onSave(item);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Menu item ${widget.item == null ? 'added' : 'updated'}',
          ),
          backgroundColor: AppTheme.avocadoGreen,
        ),
      );
    }
  }
}
