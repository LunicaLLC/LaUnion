import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';

class AdminScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const AdminScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null
            ? Text(
          title!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        )
            : null,
        backgroundColor: AppTheme.charcoal,
        foregroundColor: Colors.white,
        actions: actions,
      ),
      drawer: _buildDrawer(context),
      body: child,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.spicyRed,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Admin Panel',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'La Unión Pupusería y Taquería',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/admin',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.receipt,
            label: 'Orders',
            route: '/admin/orders',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.restaurant_menu,
            label: 'Menu',
            route: '/admin/menu',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.schedule,
            label: 'Schedule',
            route: '/admin/schedule',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.analytics,
            label: 'Analytics',
            route: '/admin/analytics',
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.store,
            label: 'Back to Store',
            route: '/',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              // Handle logout
              context.go('/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        String? route,
        VoidCallback? onTap,
      }) {
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = route != null && currentPath == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppTheme.spicyRed : AppTheme.charcoal,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppTheme.spicyRed : AppTheme.charcoal,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: onTap ?? () {
        if (route != null) {
          context.go(route);
        }
      },
      tileColor: isActive ? AppTheme.spicyRed.withOpacity(0.1) : null,
    );
  }
}