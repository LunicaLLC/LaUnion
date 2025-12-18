import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../config/theme.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';

class AppScaffold extends ConsumerStatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  bool _showAppBar = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentPath = GoRouterState.of(context).uri.path;
    final showBackButton = ![
      '/',
      '/menu',
      '/location',
      '/loyalty',
      '/profile',
      '/about',
    ].contains(currentPath);
    final isDesktop =
        MediaQuery.of(context).size.width > 800; // Desktop breakpoint

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_showAppBar ? kToolbarHeight : 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _showAppBar ? kToolbarHeight : 0,
          child: AppBar(
            leading: showBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  )
                : null,
            title: Image.asset(
              'assets/images/logo/splash_loading/CircleLogoImage2.png',
              height: 80, // Increased size
              fit: BoxFit.contain,
            ),
            backgroundColor: AppTheme.spicyRed,
            foregroundColor: Colors.white,
            actions:
                widget.actions ??
                (isDesktop
                    ? _buildDesktopActions(currentPath, l10n)
                    : [_buildLanguageSwitcher()]),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            final delta = scrollNotification.scrollDelta ?? 0;
            // Hide app bar when scrolling down, show when scrolling up
            if (delta > 5 && _showAppBar) {
              setState(() => _showAppBar = false);
            } else if (delta < -5 && !_showAppBar) {
              setState(() => _showAppBar = true);
            }
          }
          return false;
        },
        child: widget.child,
      ),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: isDesktop
          ? null
          : _buildBottomNavBar(currentPath, l10n),
    );
  }

  Widget _buildLanguageSwitcher() {
    final locale = ref.watch(localeProvider);
    return TextButton(
      onPressed: () {
        ref.read(localeProvider.notifier).toggleLocale();
      },
      child: Text(
        locale.languageCode == 'en' ? 'ES' : 'EN',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(String currentPath, AppLocalizations l10n) {
    final user = ref.watch(authProvider);
    final isAuthenticated = user != null;

    final items = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: l10n.navHome,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.restaurant_menu),
        label: l10n.navMenu,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.location_on),
        label: l10n.navLocation,
      ),
      if (isAuthenticated)
        BottomNavigationBarItem(
          icon: const Icon(Icons.loyalty),
          label: l10n.navLoyalty,
        ),
      if (isAuthenticated)
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: l10n.navProfile,
        ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.info_outline),
        label: l10n.navAbout,
      ),
    ];

    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(currentPath, isAuthenticated),
      onTap: (index) => _onNavItemTapped(index, context, isAuthenticated),
      selectedItemColor: AppTheme.spicyRed,
      unselectedItemColor: AppTheme.charcoal.withValues(alpha: 0.6),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: items,
    );
  }

  List<Widget> _buildDesktopActions(String currentPath, AppLocalizations l10n) {
    final user = ref.watch(authProvider);
    final isAuthenticated = user != null;

    return [
      _buildDesktopNavButton(l10n.navHome, '/', currentPath),
      _buildDesktopNavButton(l10n.navMenu, '/menu', currentPath),
      _buildDesktopNavButton(l10n.navLocation, '/location', currentPath),
      if (isAuthenticated)
        _buildDesktopNavButton(l10n.navLoyalty, '/loyalty', currentPath),
      _buildDesktopNavButton(l10n.navAbout, '/about', currentPath),
      if (isAuthenticated)
        _buildDesktopNavButton(l10n.navProfile, '/profile', currentPath)
      else
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () => context.go('/signin'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.spicyRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              l10n.signInButton,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      const SizedBox(width: 8),
      _buildLanguageSwitcher(),
      const SizedBox(width: 16),
    ];
  }

  Widget _buildDesktopNavButton(String label, String path, String currentPath) {
    final isSelected =
        currentPath == path || (path != '/' && currentPath.startsWith(path));
    return TextButton(
      onPressed: () => context.go(path),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  int _getCurrentIndex(String path, bool isAuthenticated) {
    if (path == '/') return 0;
    if (path.startsWith('/menu')) return 1;
    if (path.startsWith('/location')) return 2;
    if (isAuthenticated) {
      if (path.startsWith('/loyalty')) return 3;
      if (path.startsWith('/profile')) return 4;
      if (path.startsWith('/about')) return 5;
    } else {
      if (path.startsWith('/about')) return 3;
    }
    return 0;
  }

  void _onNavItemTapped(int index, BuildContext context, bool isAuthenticated) {
    if (isAuthenticated) {
      // Authenticated: Home, Menu, Location, Loyalty, Profile, About
      switch (index) {
        case 0:
          if (GoRouterState.of(context).uri.path != '/') {
            context.go('/');
          }
          break;
        case 1:
          if (!GoRouterState.of(context).uri.path.startsWith('/menu')) {
            context.go('/menu');
          }
          break;
        case 2:
          if (!GoRouterState.of(context).uri.path.startsWith('/location')) {
            context.go('/location');
          }
          break;
        case 3:
          if (!GoRouterState.of(context).uri.path.startsWith('/loyalty')) {
            context.go('/loyalty');
          }
          break;
        case 4:
          if (!GoRouterState.of(context).uri.path.startsWith('/profile')) {
            context.go('/profile');
          }
          break;
        case 5:
          if (!GoRouterState.of(context).uri.path.startsWith('/about')) {
            context.go('/about');
          }
          break;
      }
    } else {
      // Not authenticated: Home, Menu, Location, About
      switch (index) {
        case 0:
          if (GoRouterState.of(context).uri.path != '/') {
            context.go('/');
          }
          break;
        case 1:
          if (!GoRouterState.of(context).uri.path.startsWith('/menu')) {
            context.go('/menu');
          }
          break;
        case 2:
          if (!GoRouterState.of(context).uri.path.startsWith('/location')) {
            context.go('/location');
          }
          break;
        case 3:
          if (!GoRouterState.of(context).uri.path.startsWith('/about')) {
            context.go('/about');
          }
          break;
      }
    }
  }
}
