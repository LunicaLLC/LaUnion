import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order.dart';
import '../../../providers/admin_provider.dart';
import '../../../ui/layout/admin_scaffold.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';

class AdminOrdersPage extends ConsumerStatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  ConsumerState<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends ConsumerState<AdminOrdersPage> {
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminProvider.notifier).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(adminProvider).orders;

    return AdminScaffold(
      title: 'Order Management',
      child: Column(
        children: [
          // Filter tabs
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.lg,
              vertical: AppConstants.md,
            ),
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: AppConstants.sm),
                _buildFilterChip('Received', 'received'),
                const SizedBox(width: AppConstants.sm),
                _buildFilterChip('Preparing', 'preparing'),
                const SizedBox(width: AppConstants.sm),
                _buildFilterChip('Ready', 'ready'),
              ],
            ),
          ),
          // Orders list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.lg),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (_selectedFilter != 'all' &&
                    order.status.name != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedFilter = value);
      },
      backgroundColor: isSelected ? null : AppTheme.lightGrey,
      selectedColor: AppTheme.spicyRed,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.charcoal,
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id.substring(0, 8)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (status) {
                    _updateOrderStatus(order.id, status);
                  },
                  itemBuilder: (context) {
                    return OrderStatus.values.map((status) {
                      return PopupMenuItem(
                        value: status.name,
                        child: Text(status.name.toUpperCase()),
                      );
                    }).toList();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      order.status.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              Formatters.formatDateTime(order.createdAt),
              style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
            ),
            const SizedBox(height: AppConstants.md),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: AppTheme.charcoal.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  'Customer ${order.userId.substring(0, 8)}',
                  style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppTheme.charcoal.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  'Pickup: ${Formatters.formatTime(order.pickupTime)}',
                  style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}',
                      style: TextStyle(
                        color: AppTheme.charcoal.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      order.paymentMethod.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.charcoal.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Text(
                  Formatters.formatCurrency(order.total),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppTheme.spicyRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.md),
            const Divider(height: 1),
            const SizedBox(height: AppConstants.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _viewOrderDetails(order);
                    },
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _prepareOrder(order);
                    },
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Mark Ready'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.received:
        return AppTheme.citrusOrange;
      case OrderStatus.preparing:
        return AppTheme.cornYellow;
      case OrderStatus.ready:
        return AppTheme.avocadoGreen;
      case OrderStatus.completed:
        return AppTheme.avocadoGreen.withOpacity(0.8);
      case OrderStatus.cancelled:
        return AppTheme.spicyRed;
    }
  }

  void _updateOrderStatus(String orderId, String status) {
    final orderStatus = OrderStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => OrderStatus.received,
    );

    ref.read(adminProvider.notifier).updateOrderStatus(orderId, orderStatus);
  }

  void _viewOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.id.substring(0, 8)}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildDetailRow('Customer ID', order.userId),
              _buildDetailRow('Status', order.status.name),
              _buildDetailRow('Total', Formatters.formatCurrency(order.total)),
              _buildDetailRow(
                'Pickup Time',
                Formatters.formatDateTime(order.pickupTime),
              ),
              _buildDetailRow('Payment Method', order.paymentMethod.name),
              _buildDetailRow(
                'Created',
                Formatters.formatDateTime(order.createdAt),
              ),
              const SizedBox(height: AppConstants.lg),
              const Text(
                'Items:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              ...order.items.map((item) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.menuItemName),
                  subtitle: Text(
                    '${item.quantity}x • ${Formatters.formatCurrency(item.price)}',
                  ),
                  trailing: Text(Formatters.formatCurrency(item.subtotal)),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _prepareOrder(Order order) {
    if (order.status != OrderStatus.ready) {
      _updateOrderStatus(order.id, OrderStatus.ready.name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order marked as ready'),
          backgroundColor: AppTheme.avocadoGreen,
        ),
      );
    }
  }
}
