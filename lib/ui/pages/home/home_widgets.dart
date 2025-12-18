import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme.dart';
import '../../../config/constants.dart';
import 'package:launionweb/l10n/app_localizations.dart';

class HomeLocationWidget extends StatelessWidget {
  const HomeLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.xxl,
        horizontal: AppConstants.lg,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.homeLocationTitle,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.charcoal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConstants.xl),
              // Map Placeholder
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.lightGrey,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 64, color: Colors.grey),
                      const SizedBox(height: AppConstants.md),
                      Text(
                        AppLocalizations.of(context)!.mapComingSoon,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.xl),
              Container(
                padding: const EdgeInsets.all(AppConstants.xl),
                decoration: BoxDecoration(
                  color: AppTheme.avocadoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.avocadoGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.avocadoGreen,
                      size: 32,
                    ),
                    const SizedBox(width: AppConstants.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.currentLocationLabel,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: AppTheme.charcoal.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                          ),
                          const SizedBox(height: AppConstants.xs),
                          Text(
                            'Downtown Plaza (Mock Location)',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.nextDepartureLabel,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: AppTheme.charcoal.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                          ),
                          const SizedBox(height: AppConstants.xs),
                          Text(
                            '5:00 PM',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.avocadoGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.xl,
                          vertical: AppConstants.lg,
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.notifyMe),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTestimonialsWidget extends StatelessWidget {
  const HomeTestimonialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.cream,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.xxl,
        horizontal: AppConstants.lg,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.customerLove,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.charcoal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConstants.xl),
              Wrap(
                spacing: AppConstants.lg,
                runSpacing: AppConstants.lg,
                alignment: WrapAlignment.center,
                children: [
                  _buildTestimonialCard(
                    context,
                    AppLocalizations.of(context)!.customerReview1,
                    'Maria G.',
                  ),
                  _buildTestimonialCard(
                    context,
                    AppLocalizations.of(context)!.customerReview2,
                    'John D.',
                  ),
                  _buildTestimonialCard(
                    context,
                    AppLocalizations.of(context)!.customerReview3,
                    'Sarah L.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(
    BuildContext context,
    String text,
    String author,
  ) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(AppConstants.xl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.star, color: AppTheme.maizeYellow, size: 32),
          const SizedBox(height: AppConstants.md),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: AppTheme.charcoal,
            ),
          ),
          const SizedBox(height: AppConstants.md),
          Text(
            author,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.spicyRed,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeLoyaltyWidget extends StatelessWidget {
  const HomeLoyaltyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.avocadoGreen.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.xxl,
        horizontal: AppConstants.lg,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(AppConstants.xxl),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.avocadoGreen.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.loyalty, color: AppTheme.avocadoGreen, size: 64),
              const SizedBox(height: AppConstants.lg),
              Text(
                AppLocalizations.of(context)!.joinLoyaltyProgram,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.charcoal,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.md),
              Text(
                AppLocalizations.of(context)!.loyaltyDescription,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.xl),
              ElevatedButton(
                onPressed: () => context.go('/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.avocadoGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.signUpNow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
