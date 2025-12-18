import 'package:flutter/material.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/order.dart';
import '../../../providers/order_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../layout/app_scaffold.dart';

class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  ConsumerState<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends ConsumerState<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider);
      if (user != null) {
        ref.read(orderProvider.notifier).loadUserOrders(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    final user = ref.read(authProvider);

    if (user == null) {
      return AppScaffold(
        title: AppLocalizations.of(context)!.orderHistoryTitle,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.pleaseSignInOrders),
              const SizedBox(height: AppConstants.lg),
              ElevatedButton(
                onPressed: () {
                  // Navigate to sign in
                },
                child: Text(AppLocalizations.of(context)!.signIn),
              ),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      title: AppLocalizations.of(context)!.orderHistoryTitle,
      child: orders.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noOrdersYet))
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.lg),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(order, context);
              },
            ),
    );
  }

  Widget _buildOrderCard(Order order, BuildContext context) {
    return AppCard(
      onTap: () => context.go('/orders/${order.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocalizations.of(context)!.orderNumber} #${order.id.substring(0, 8)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Chip(
                label: Text(order.status.name.toUpperCase()),
                backgroundColor: _getStatusColor(order.status),
                labelStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            Formatters.formatDateTime(order.createdAt),
            style: TextStyle(color: AppTheme.charcoal.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.itemCount(order.items.length),
                style: TextStyle(
                  color: AppTheme.charcoal.withValues(alpha: 0.8),
                ),
              ),
              Text(
                Formatters.formatCurrency(order.total),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.spicyRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          const Divider(height: 1),
          const SizedBox(height: AppConstants.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => context.go('/orders/${order.id}'),
                child: Text(AppLocalizations.of(context)!.viewDetails),
              ),
              ElevatedButton(
                onPressed: () {
                  // Reorder
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.spicyRed,
                ),
                child: Text(AppLocalizations.of(context)!.reorder),
              ),
            ],
          ),
        ],
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
        return AppTheme.avocadoGreen.withValues(alpha: 0.8);
      case OrderStatus.cancelled:
        return AppTheme.spicyRed;
    }
  }
}
