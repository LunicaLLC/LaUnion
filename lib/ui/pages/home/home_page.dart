import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../providers/menu_provider.dart';
import '../../widgets/web_footer.dart';
import 'home_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(menuProvider.notifier).loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final menuItems = ref.watch(menuProvider);

    return CustomScrollView(
      slivers: [
        // Hero Section
        SliverToBoxAdapter(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.charcoal,
              image: DecorationImage(
                image: AssetImage('assets/images/short-foods-image.webp'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants
                        .xxl, // Add vertical padding to prevent edge touches on small screens
                    horizontal: AppConstants.lg,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.xl),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo/weblogo.png',
                          height: 280, // Increased size as requested
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: AppConstants.md),
                        // Outlined Title
                        Stack(
                          children: [
                            // Stroke text
                            Text(
                              l10n.heroTitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.0,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.white,
                                  ),
                            ),
                            // Filled text
                            Text(
                              l10n.heroTitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.0,
                                    color: AppTheme.spicyRed, // Inner color
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        offset: const Offset(0, 4),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.md),
                        Text(
                          l10n.heroSubtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: AppTheme.citrusOrange,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(height: AppConstants.lg),
                        Text(
                          l10n.heroDescription,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.95),
                                fontStyle: FontStyle.italic,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(height: AppConstants.xxl),
                        if (MediaQuery.of(context).size.width > 800)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                child: ElevatedButton(
                                  onPressed: () => context.go('/menu'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    backgroundColor: AppTheme.spicyRed,
                                    foregroundColor: Colors.white,
                                    elevation: 8,
                                    shadowColor: AppTheme.spicyRed.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.btnOrderNow.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppConstants.md),
                              SizedBox(
                                width: 250,
                                child: OutlinedButton(
                                  onPressed: () => context.go('/location'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.btnFindTruck.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 250, // width constraint for buttons
                                child: ElevatedButton(
                                  onPressed: () => context.go('/menu'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    backgroundColor: AppTheme.spicyRed,
                                    foregroundColor: Colors.white,
                                    elevation: 8,
                                    shadowColor: AppTheme.spicyRed.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.btnOrderNow.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppConstants.md),
                              SizedBox(
                                width: 250,
                                child: OutlinedButton(
                                  onPressed: () => context.go('/location'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.btnFindTruck.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Menu Preview
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.xxl,
              horizontal: AppConstants.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.featuredItems,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppTheme.charcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Container(width: 60, height: 4, color: AppTheme.spicyRed),
                const SizedBox(height: AppConstants.xl),

                menuItems.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: AppConstants.lg,
                              mainAxisSpacing: AppConstants.lg,
                            ),
                        // Show max 4 items
                        itemCount: menuItems.take(4).length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child:
                                      item.imageUrl != null &&
                                          item.imageUrl!.startsWith('assets/')
                                      ? Image.asset(
                                          item.imageUrl!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: AppTheme.lightGrey,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.fastfood,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                        )
                                      : Image.network(
                                          item.imageUrl ?? '',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: AppTheme.lightGrey,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.fastfood,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                    AppConstants.md,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: AppConstants.xs),
                                      Text(
                                        item.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey[600]),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: AppConstants.md),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${item.price.toStringAsFixed(2)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  color: AppTheme.spicyRed,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add_shopping_cart,
                                              color: AppTheme.citrusOrange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                const SizedBox(height: AppConstants.xl),
                OutlinedButton(
                  onPressed: () => context.go('/menu'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.xl,
                      vertical: AppConstants.lg,
                    ),
                    side: const BorderSide(color: AppTheme.spicyRed),
                  ),
                  child: Text(
                    l10n.viewFullMenu,
                    style: const TextStyle(
                      color: AppTheme.spicyRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Testimonials
        const SliverToBoxAdapter(child: HomeTestimonialsWidget()),

        // Loyalty Section
        const SliverToBoxAdapter(child: HomeLoyaltyWidget()),

        // Global Footer
        const SliverToBoxAdapter(child: WebFooter()),
      ],
    );
  }
}
