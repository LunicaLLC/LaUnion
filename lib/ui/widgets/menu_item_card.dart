import 'package:flutter/material.dart';
import '../../models/menu_item.dart';
import '../shared/app_card.dart';
import '../../config/theme.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAddToCart;
  final bool showAddButton;
  final VoidCallback? onTap;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.onAddToCart,
    this.showAddButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
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
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.imageUrl!.startsWith('assets/')
                        ? Image.asset(item.imageUrl!, fit: BoxFit.cover)
                        : Image.network(item.imageUrl!, fit: BoxFit.cover),
                  )
                : Center(
                    child: Icon(
                      Icons.fastfood,
                      size: 48,
                      color: AppTheme.charcoal.withOpacity(0.3),
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.charcoal.withOpacity(0.6),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: AppTheme.spicyRed,
                ),
              ),
              if (showAddButton)
                IconButton(
                  onPressed: onAddToCart,
                  icon: Icon(
                    Icons.add_circle,
                    color: AppTheme.spicyRed,
                    size: 28,
                  ),
                ),
            ],
          ),
          if (item.tags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: item.tags.map((tag) {
                return Chip(
                  label: Text(tag.toUpperCase()),
                  backgroundColor: _getTagColor(tag),
                  labelStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'spicy':
        return AppTheme.spicyRed.withOpacity(0.1);
      case 'vegetarian':
        return AppTheme.avocadoGreen.withOpacity(0.1);
      case 'gluten-free':
        return AppTheme.cornYellow.withOpacity(0.1);
      default:
        return AppTheme.lightGrey;
    }
  }
}
