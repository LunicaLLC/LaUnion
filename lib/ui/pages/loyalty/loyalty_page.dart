import 'package:flutter/material.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/loyalty_transaction.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/loyalty_provider.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../widgets/loyalty_progress.dart';
import '../../widgets/web_footer.dart';

class LoyaltyPage extends ConsumerStatefulWidget {
  const LoyaltyPage({super.key});

  @override
  ConsumerState<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends ConsumerState<LoyaltyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider);
      if (user != null) {
        ref.read(loyaltyProvider.notifier).loadLoyaltyData(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authProvider);
    final loyaltyState = ref.watch(loyaltyProvider);
    final loyaltyNotifier = ref.read(loyaltyProvider.notifier);

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.loyalty, size: 64, color: AppTheme.lightGrey),
            const SizedBox(height: AppConstants.lg),
            Text(
              AppLocalizations.of(context)!.joinLoyaltyProgram,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: AppConstants.md),
            Text(
              AppLocalizations.of(context)!.signInToEarnPoints,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.xl),
            ElevatedButton(
              onPressed: () {
                // Navigate to sign in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.spicyRed,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.xl,
                  vertical: AppConstants.lg,
                ),
              ),
              child: Text(AppLocalizations.of(context)!.signIn),
            ),
          ],
        ),
      );
    }

    final nextRewardPoints = loyaltyNotifier.getNextRewardPoints();
    final nextRewardName = loyaltyNotifier.getNextRewardName() ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Text(
            AppLocalizations.of(
              context,
            )!.welcomeBackUser(user.name ?? 'Valued Customer'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            AppLocalizations.of(context)!.keepEating,
            style: TextStyle(color: AppTheme.charcoal.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: AppConstants.xl),
          // Progress bar
          LoyaltyProgress(
            currentPoints: loyaltyState.points,
            nextRewardPoints: nextRewardPoints,
            nextRewardName: nextRewardName,
          ),
          const SizedBox(height: AppConstants.xl),
          // Rewards section
          Text(
            AppLocalizations.of(context)!.availableRewards,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.citrusOrange),
          ),
          const SizedBox(height: AppConstants.md),
          _buildRewardsGrid(loyaltyState, nextRewardPoints),
          const SizedBox(height: AppConstants.xl),
          // Referral program
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.share, color: AppTheme.spicyRed),
                    const SizedBox(width: AppConstants.md),
                    Text(
                      AppLocalizations.of(context)!.referFriend,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  AppLocalizations.of(context)!.referralDescription,
                  style: TextStyle(
                    color: AppTheme.charcoal.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppConstants.lg),
                if (loyaltyState.referralCode != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.yourReferralCode,
                        style: TextStyle(
                          color: AppTheme.charcoal.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: AppConstants.sm),
                      Container(
                        padding: const EdgeInsets.all(AppConstants.md),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                loyaltyState.referralCode!,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Copy to clipboard
                                _copyToClipboard(loyaltyState.referralCode!);
                              },
                              icon: const Icon(Icons.content_copy),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: AppConstants.lg),
                ElevatedButton(
                  onPressed: () {
                    // Share referral
                    _shareReferral(loyaltyState.referralCode);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.spicyRed,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(AppLocalizations.of(context)!.shareReferralLink),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),
          // Transaction history
          Text(
            AppLocalizations.of(context)!.recentActivity,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.citrusOrange),
          ),
          const SizedBox(height: AppConstants.md),
          ...loyaltyState.transactions.take(5).map((transaction) {
            return _buildTransactionCard(transaction);
          }),
          if (loyaltyState.transactions.length > 5)
            TextButton(
              onPressed: () {
                // View all transactions
              },
              child: Text(AppLocalizations.of(context)!.viewAllActivity),
            ),
          const SizedBox(height: AppConstants.xxl),
          const WebFooter(),
        ],
      ),
    );
  }

  Widget _buildRewardsGrid(LoyaltyState loyaltyState, int nextRewardPoints) {
    final rewards = {
      500: AppLocalizations.of(context)!.rewardFreeDrink,
      1000: AppLocalizations.of(context)!.rewardFreePupusa,
      1500: AppLocalizations.of(context)!.rewardTenOff,
      2500: AppLocalizations.of(context)!.rewardFamilyMeal,
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.lg,
        mainAxisSpacing: AppConstants.lg,
        childAspectRatio: 1.2,
      ),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final points = rewards.keys.elementAt(index);
        final reward = rewards[points]!;
        final isUnlocked = loyaltyState.points >= points;
        final isNext =
            points ==
            nextRewardPoints; // ✅ Fixed: Use nextRewardPoints parameter

        return AppCard(
          backgroundColor: isUnlocked
              ? AppTheme.avocadoGreen.withValues(alpha: 0.1)
              : isNext
              ? AppTheme.cornYellow.withValues(alpha: 0.1)
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$points',
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: AppTheme.spicyRed,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.pointsUppercase,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.charcoal.withValues(alpha: 0.6),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: AppConstants.md),
              Text(
                reward,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppConstants.sm),
              if (isUnlocked)
                Text(
                  AppLocalizations.of(context)!.unlocked,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.avocadoGreen,
                    letterSpacing: 1,
                  ),
                )
              else if (isNext)
                Text(
                  '${points - loyaltyState.points} ${AppLocalizations.of(context)!.toGo}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.cornYellow,
                  ),
                )
              else
                Text(
                  AppLocalizations.of(context)!.locked,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.charcoal.withValues(alpha: 0.3),
                    letterSpacing: 1,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionCard(LoyaltyTransaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getTransactionColor(transaction.type),
              ),
              child: Icon(
                _getTransactionIcon(transaction.type),
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: AppConstants.md),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTransactionDescription(transaction.type),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    Formatters.formatTimeAgo(transaction.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.charcoal.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Points
            Text(
              '${transaction.points > 0 ? '+' : ''}${transaction.points}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: transaction.points > 0
                    ? AppTheme.avocadoGreen
                    : AppTheme.spicyRed,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTransactionColor(LoyaltyTransactionType type) {
    switch (type) {
      case LoyaltyTransactionType.purchase:
        return AppTheme.spicyRed;
      case LoyaltyTransactionType.referral:
        return AppTheme.citrusOrange;
      case LoyaltyTransactionType.redemption:
        return AppTheme.avocadoGreen;
      case LoyaltyTransactionType.bonus:
        return AppTheme.cornYellow;
    }
  }

  IconData _getTransactionIcon(LoyaltyTransactionType type) {
    switch (type) {
      case LoyaltyTransactionType.purchase:
        return Icons.shopping_bag;
      case LoyaltyTransactionType.referral:
        return Icons.people;
      case LoyaltyTransactionType.redemption:
        return Icons.card_giftcard;
      case LoyaltyTransactionType.bonus:
        return Icons.star;
    }
  }

  String _getTransactionDescription(LoyaltyTransactionType type) {
    switch (type) {
      case LoyaltyTransactionType.purchase:
        return AppLocalizations.of(context)!.transPurchase;
      case LoyaltyTransactionType.referral:
        return AppLocalizations.of(context)!.transReferral;
      case LoyaltyTransactionType.redemption:
        return AppLocalizations.of(context)!.transRedemption;
      case LoyaltyTransactionType.bonus:
        return AppLocalizations.of(context)!.transBonus;
    }
  }

  void _copyToClipboard(String text) {
    // In a real app, use clipboard package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.copiedToClipboard(text)),
        backgroundColor: AppTheme.avocadoGreen,
      ),
    );
  }

  void _shareReferral(String? referralCode) {
    if (referralCode == null) return;

    // In a real app, use share package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.shareYourCode(referralCode),
        ),
        backgroundColor: AppTheme.avocadoGreen,
      ),
    );
  }
}
