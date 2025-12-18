import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../models/order.dart';
import '../../../providers/order_provider.dart';
import '../../../ui/shared/app_button.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../shared/app_card.dart';
import '../../widgets/status_timeline.dart';
import '../../layout/app_scaffold.dart';

class OrderStatusPage extends ConsumerStatefulWidget {
  final String orderId;

  const OrderStatusPage({super.key, required this.orderId});

  @override
  ConsumerState<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends ConsumerState<OrderStatusPage> {
  Order? _order;

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    try {
      final order = await ref
          .read(orderProvider.notifier)
          .getOrderById(widget.orderId);
      setState(() => _order = order);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_order == null) {
      return AppScaffold(
        title: AppLocalizations.of(context)!.orderStatusTitle,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final order = _order!;
    final statusTimes = {
      AppLocalizations.of(context)!.statusReceived: order.createdAt,
      AppLocalizations.of(context)!.statusPreparing: order.createdAt.add(
        const Duration(minutes: 5),
      ),
      AppLocalizations.of(context)!.statusReady: order.pickupTime,
      AppLocalizations.of(
        context,
      )!.statusCompleted: order.status == OrderStatus.completed
          ? order.pickupTime.add(const Duration(minutes: 15))
          : null,
    };

    return AppScaffold(
      title:
          '${AppLocalizations.of(context)!.orderNumber} #${order.id.substring(0, 8)}',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status header
            AppCard(
              child: Column(
                children: [
                  Text(
                    _getStatusMessage(context, order.status),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: _getStatusColor(order.status),
                    ),
                  ),
                  const SizedBox(height: AppConstants.sm),
                  Text(
                    AppLocalizations.of(context)!.estimatedPickup(
                      Formatters.formatDateTime(order.pickupTime),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.xl),
            // Timeline
            Text(
              AppLocalizations.of(context)!.orderProgress,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppConstants.lg),
            StatusTimeline(
              currentStatus: order
                  .status
                  .name, // Timeline might need separate logic if it uses raw strings or keys
              statusTimes: statusTimes,
            ),
            const SizedBox(height: AppConstants.xl),
            // Order details
            Text(
              AppLocalizations.of(context)!.orderDetails,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppConstants.lg),
            AppCard(
              child: Column(
                children: [
                  _buildDetailRow(
                    AppLocalizations.of(context)!.orderNumber,
                    '#${order.id.substring(0, 8)}',
                  ),
                  _buildDetailRow(
                    AppLocalizations.of(context)!.placed,
                    Formatters.formatDateTime(order.createdAt),
                  ),
                  _buildDetailRow(
                    AppLocalizations.of(context)!.pickupTimeLabel,
                    Formatters.formatDateTime(order.pickupTime),
                  ),
                  _buildDetailRow(
                    AppLocalizations.of(context)!.paymentMethodLabel,
                    order.paymentMethod.name,
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    AppLocalizations.of(context)!.total,
                    Formatters.formatCurrency(order.total),
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.xl),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // View order details
                    },
                    child: Text(AppLocalizations.of(context)!.viewReceipt),
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                Expanded(
                  child: AppButton(
                    text: AppLocalizations.of(context)!.orderAgain,
                    onPressed: () {
                      // Reorder
                    },
                    primary: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.lg),
            Center(
              child: TextButton(
                onPressed: () {
                  // Need help
                },
                child: Text(AppLocalizations.of(context)!.needHelpOrder),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.charcoal.withValues(alpha: 0.6),
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? AppTheme.spicyRed : AppTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusMessage(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.received:
        return AppLocalizations.of(context)!.orderReceived;
      case OrderStatus.preparing:
        return AppLocalizations.of(context)!.orderPreparing;
      case OrderStatus.ready:
        return AppLocalizations.of(context)!.orderReady;
      case OrderStatus.completed:
        return AppLocalizations.of(context)!.orderCompleted;
      case OrderStatus.cancelled:
        return AppLocalizations.of(context)!.orderCancelled;
    }
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
        return AppTheme.avocadoGreen;
      case OrderStatus.cancelled:
        return AppTheme.spicyRed;
    }
  }
}
