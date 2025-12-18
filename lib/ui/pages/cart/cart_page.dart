import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../providers/cart_provider.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../widgets/order_summary.dart';
import '../../layout/app_scaffold.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    final subtotal = cartNotifier.subtotal;
    final tax = cartNotifier.tax;
    final total = cartNotifier.total;
    final itemCount = cartNotifier.itemCount;

    return AppScaffold(
      title: l10n.cartTitle,
      child: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Text(
                      l10n.cartEmpty,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.lg),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _buildCartItem(context, item, cartNotifier);
                    },
                  ),
          ),
          if (cartItems.isNotEmpty)
            OrderSummary(
              subtotal: subtotal,
              tax: tax,
              total: total,
              itemCount: itemCount,
              onCheckout: () {
                // Navigate to checkout
                Navigator.of(context).pushNamed('/checkout');
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartItem cartItem,
    CartNotifier notifier,
  ) {
    final item = cartItem.menuItem;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.lightGrey,
              ),
              child: item.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(item.imageUrl!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 32,
                        color: AppTheme.charcoal.withOpacity(0.3),
                      ),
                    ),
            ),
            const SizedBox(width: AppConstants.md),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Formatters.formatCurrency(item.price),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.spicyRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (cartItem.selectedModifiers.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      cartItem.selectedModifiers.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.charcoal.withOpacity(0.6),
                      ),
                    ),
                  ],
                  if (cartItem.specialInstructions != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.notePrefix(cartItem.specialInstructions!),
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.charcoal.withOpacity(0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            // Quantity controls
            Column(
              children: [
                IconButton(
                  onPressed: () =>
                      notifier.updateQuantity(item.id, cartItem.quantity + 1),
                  icon: Icon(Icons.add_circle, color: AppTheme.spicyRed),
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      notifier.updateQuantity(item.id, cartItem.quantity - 1),
                  icon: Icon(Icons.remove_circle, color: AppTheme.spicyRed),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
