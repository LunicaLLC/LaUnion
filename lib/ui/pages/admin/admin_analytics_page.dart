import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/admin_provider.dart';
import '../../../ui/layout/admin_scaffold.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';

class AdminAnalyticsPage extends ConsumerStatefulWidget {
  const AdminAnalyticsPage({super.key});

  @override
  ConsumerState<AdminAnalyticsPage> createState() => _AdminAnalyticsPageState();
}

class _AdminAnalyticsPageState extends ConsumerState<AdminAnalyticsPage> {
  String _selectedPeriod = 'today';

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
      title: 'Analytics',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            Row(
              children: [
                _buildPeriodChip('Today', 'today'),
                const SizedBox(width: AppConstants.sm),
                _buildPeriodChip('Week', 'week'),
                const SizedBox(width: AppConstants.sm),
                _buildPeriodChip('Month', 'month'),
                const SizedBox(width: AppConstants.sm),
                _buildPeriodChip('Year', 'year'),
              ],
            ),
            const SizedBox(height: AppConstants.xl),
            // Key metrics
            Text(
              'KEY METRICS',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.citrusOrange,
              ),
            ),
            const SizedBox(height: AppConstants.md),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.lg,
              mainAxisSpacing: AppConstants.lg,
              childAspectRatio: 1.2,
              children: [
                _buildMetricCard(
                  'Total Sales',
                  Formatters.formatCurrency(analytics['dailySales'] ?? 0.0),
                  AppTheme.spicyRed,
                  Icons.attach_money,
                ),
                _buildMetricCard(
                  'Orders',
                  '${analytics['totalOrders'] ?? 0}',
                  AppTheme.citrusOrange,
                  Icons.receipt,
                ),
                _buildMetricCard(
                  'Avg Order',
                  Formatters.formatCurrency(analytics['averageOrderValue'] ?? 0.0),
                  AppTheme.cornYellow,
                  Icons.shopping_cart,
                ),
                _buildMetricCard(
                  'Customers',
                  '${analytics['loyaltySignups'] ?? 0}',
                  AppTheme.avocadoGreen,
                  Icons.people,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.xl),
            // Top items
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOP SELLING ITEMS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.lg),
                  ..._buildTopItemsList(analytics),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.xl),
            // Busy times
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BUSIEST TIMES',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.lg),
                  ..._buildBusyTimesList(analytics),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.xl),
            // Export section
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATA EXPORT',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.lg),
                  Text(
                    'Export your analytics data for further analysis',
                    style: TextStyle(
                      color: AppTheme.charcoal.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: AppConstants.lg),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _exportData('CSV');
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Export as CSV'),
                        ),
                      ),
                      const SizedBox(width: AppConstants.md),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _exportData('PDF');
                          },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text('Export as PDF'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(String label, String value) {
    final isSelected = _selectedPeriod == value;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedPeriod = value);
      },
      backgroundColor: isSelected ? null : AppTheme.lightGrey,
      selectedColor: AppTheme.spicyRed,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.charcoal,
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color, IconData icon) {
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

  List<Widget> _buildTopItemsList(Map<String, dynamic> analytics) {
    final topItems = analytics['topItems'] as List<dynamic>? ?? [];

    if (topItems.isEmpty) {
      return [
        const Text(
          'No data available',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ];
    }

    return topItems.map<Widget>((item) {
      final name = item['name'] as String;
      final count = item['count'] as int;

      return Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: AppTheme.lightGrey,
              child: Text(
                '${topItems.indexOf(item) + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.charcoal,
                ),
              ),
            ),
            title: Text(name),
            trailing: Text(
              '$count orders',
              style: TextStyle(
                color: AppTheme.charcoal.withOpacity(0.6),
              ),
            ),
          ),
          if (topItems.indexOf(item) < topItems.length - 1)
            const Divider(height: 1),
        ],
      );
    }).toList();
  }

  List<Widget> _buildBusyTimesList(Map<String, dynamic> analytics) {
    final busyTimes = analytics['busiestTimes'] as List<dynamic>? ?? [];

    if (busyTimes.isEmpty) {
      return [
        const Text(
          'No data available',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ];
    }

    return busyTimes.map<Widget>((time) {
      return Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time),
            title: Text(time.toString()),
            trailing: const Icon(Icons.trending_up, color: AppTheme.spicyRed),
          ),
          if (busyTimes.indexOf(time) < busyTimes.length - 1)
            const Divider(height: 1),
        ],
      );
    }).toList();
  }

  void _exportData(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting data as $format...'),
        backgroundColor: AppTheme.avocadoGreen,
      ),
    );
  }
}