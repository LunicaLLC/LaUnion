import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/layout/app_scaffold.dart'; // Changed import
import 'ui/pages/location/truck_map_page.dart';
import 'ui/pages/menu/menu_page.dart';
import 'ui/pages/menu/item_details_page.dart';
import 'ui/pages/cart/cart_page.dart';
import 'ui/pages/checkout/checkout_page.dart';
import 'ui/pages/loyalty/loyalty_page.dart';
import 'ui/pages/profile/profile_page.dart';
import 'ui/pages/orders/order_status_page.dart';
import 'ui/pages/orders/order_history_page.dart';
import 'ui/pages/admin/admin_dashboard_page.dart';
import 'ui/pages/admin/admin_orders_page.dart';
import 'ui/pages/admin/admin_menu_page.dart';
import 'ui/pages/admin/admin_schedule_page.dart';
import 'ui/pages/admin/admin_analytics_page.dart';
import 'ui/pages/about/about_page.dart';
import 'ui/pages/auth/sign_in_page.dart';
import 'ui/pages/auth/sign_up_page.dart';
import 'ui/pages/catering/catering_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Shell route for bottom navigation pages
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage()),
          ),
          GoRoute(
            path: '/menu',
            name: 'menu',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const MenuPage(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                name: 'item-details',
                pageBuilder: (context, state) => _buildPageWithFade(
                  context: context,
                  state: state,
                  child: ItemDetailsPage(
                    itemId: state.pathParameters['id'] ?? '',
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/location',
            name: 'location',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const TruckMapPage(),
            ),
          ),
          GoRoute(
            path: '/loyalty',
            name: 'loyalty',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const LoyaltyPage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const ProfilePage(),
            ),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const AboutPage(),
            ),
          ),
          GoRoute(
            path: '/catering',
            name: 'catering',
            pageBuilder: (context, state) => _buildPageWithFade(
              context: context,
              state: state,
              child: const CateringPage(),
            ),
          ),
        ],
      ),

      // Routes without bottom navigation (standalone pages)
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) => const MaterialPage(child: CartPage()),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        pageBuilder: (context, state) =>
            const MaterialPage(child: CheckoutPage()),
      ),
      GoRoute(
        path: '/orders',
        name: 'order-history',
        pageBuilder: (context, state) =>
            const MaterialPage(child: OrderHistoryPage()),
      ),
      GoRoute(
        path: '/orders/:id',
        name: 'order-status',
        pageBuilder: (context, state) => MaterialPage(
          child: OrderStatusPage(orderId: state.pathParameters['id'] ?? ''),
        ),
      ),

      // Admin routes
      GoRoute(
        path: '/admin',
        name: 'admin-dashboard',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminDashboardPage()),
      ),
      GoRoute(
        path: '/admin/orders',
        name: 'admin-orders',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminOrdersPage()),
      ),
      GoRoute(
        path: '/admin/menu',
        name: 'admin-menu',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminMenuPage()),
      ),
      GoRoute(
        path: '/admin/schedule',
        name: 'admin-schedule',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminSchedulePage()),
      ),
      GoRoute(
        path: '/admin/analytics',
        name: 'admin-analytics',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminAnalyticsPage()),
      ),

      // Auth routes
      GoRoute(
        path: '/signin',
        name: 'signin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignInPage()),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignUpPage()),
      ),
    ],
  );

  static Page<dynamic> _buildPageWithFade({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
