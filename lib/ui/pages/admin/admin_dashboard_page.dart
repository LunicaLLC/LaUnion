import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/admin_provider.dart';
import '../../../ui/layout/admin_scaffold.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminProvider.notifier).loadAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final analytics = ref.watch(adminProvider).analytics;

    return AdminScaffold(
      title: 'Dashboard',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            Text(
              'Good ${_getTimeOfDayGreeting()}, Admin!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              'Here\'s what\'s happening today',
              style: TextStyle(
                color: AppTheme.charcoal.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppConstants.xl),
            // Stats grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.lg,
              mainAxisSpacing: AppConstants.lg,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard(
                  icon: Icons.attach_money,
                  label: 'Today\'s Sales',
                  value: Formatters.formatCurrency(analytics['dailySales'] ?? 0.0),
                  color: AppTheme.spicyRed,
                ),
                _buildStatCard(
                  icon: Icons.receipt,
                  label: 'Total Orders',
                  value: '${analytics['totalOrders'] ?? 0}',
                  color: AppTheme.citrusOrange,
                ),
                _buildStatCard(
                  icon: Icons.shopping_cart,
                  label: 'Avg Order Value',
                  value: Formatters.formatCurrency(analytics['averageOrderValue'] ?? 0.0),
                  color: AppTheme.cornYellow,
                ),
                _buildStatCard(
                  icon: Icons.people,
                  label: 'Loyalty Signups',
                  value: '${analytics['loyaltySignups'] ?? 0}',
                  color: AppTheme.avocadoGreen,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.xl),
            // Quick actions
            Text(
              'QUICK ACTIONS',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.citrusOrange,
              ),
            ),
            const SizedBox(height: AppConstants.md),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.md,
              mainAxisSpacing: AppConstants.md,
              childAspectRatio: 1.5,
              children: [
                _buildActionCard(
                  icon: Icons.receipt,
                  label: 'View Orders',
                  route: '/admin/orders',
                ),
                _buildActionCard(
                  icon: Icons.restaurant_menu,
                  label: 'Manage Menu',
                  route: '/admin/menu',
                ),
                _buildActionCard(
                  icon: Icons.schedule,
                  label: 'Update Schedule',
                  route: '/admin/schedule',
                ),
                _buildActionCard(
                  icon: Icons.analytics,
                  label: 'View Analytics',
                  route: '/admin/analytics',
                ),
              ],
            ),
            const SizedBox(height: AppConstants.xl),
            // Recent activity
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECENT ACTIVITY',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.lg),
                  // Recent orders would go here
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.receipt, size: 20),
                    ),
                    title: Text('New order received'),
                    subtitle: Text('2 minutes ago'),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.restaurant, size: 20),
                    ),
                    title: Text('Menu item updated'),
                    subtitle: Text('15 minutes ago'),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.location_on, size: 20),
                    ),
                    title: Text('Location updated'),
                    subtitle: Text('1 hour ago'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: AppConstants.md),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.charcoal.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required String route,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to route
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: AppTheme.spicyRed,
              ),
              const SizedBox(height: AppConstants.md),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeOfDayGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }
}