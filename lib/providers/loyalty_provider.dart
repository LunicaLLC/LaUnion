import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_service.dart';
import '../models/loyalty_transaction.dart';

class LoyaltyState {
  final int points;
  final List<LoyaltyTransaction> transactions;
  final String? referralCode;

  LoyaltyState({
    this.points = 0,
    this.transactions = const [],
    this.referralCode,
  });

  LoyaltyState copyWith({
    int? points,
    List<LoyaltyTransaction>? transactions,
    String? referralCode,
  }) {
    return LoyaltyState(
      points: points ?? this.points,
      transactions: transactions ?? this.transactions,
      referralCode: referralCode ?? this.referralCode,
    );
  }
}

final loyaltyProvider = StateNotifierProvider<LoyaltyNotifier, LoyaltyState>((ref) {
  return LoyaltyNotifier();
});

class LoyaltyNotifier extends StateNotifier<LoyaltyState> {
  final _supabaseService = SupabaseService();

  LoyaltyNotifier() : super(LoyaltyState());

  Future<void> loadLoyaltyData(String userId) async {
    try {
      // Mock data
      await Future.delayed(const Duration(seconds: 1));

      state = LoyaltyState(
        points: 750,
        referralCode: 'REF123456',
        transactions: [
          LoyaltyTransaction(
            id: 'tx_001',
            userId: userId,
            points: 250,
            type: LoyaltyTransactionType.purchase,
            orderId: 'order_001',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
          LoyaltyTransaction(
            id: 'tx_002',
            userId: userId,
            points: 500,
            type: LoyaltyTransactionType.purchase,
            orderId: 'order_002',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load loyalty data: $e');
    }
  }

  void addPoints(int points, {String? orderId, LoyaltyTransactionType type = LoyaltyTransactionType.purchase}) {
    final transaction = LoyaltyTransaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'current_user', // Would be real user ID in production
      points: points,
      type: type,
      orderId: orderId,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      points: state.points + points,
      transactions: [transaction, ...state.transactions],
    );
  }

  bool redeemPoints(int points) {
    if (state.points >= points) {
      final transaction = LoyaltyTransaction(
        id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'current_user',
        points: -points,
        type: LoyaltyTransactionType.redemption,
        createdAt: DateTime.now(),
      );

      state = state.copyWith(
        points: state.points - points,
        transactions: [transaction, ...state.transactions],
      );
      return true;
    }
    return false;
  }

  int getNextRewardPoints() {
    const rewards = [500, 1000, 1500, 2500];
    final nextReward = rewards.firstWhere(
          (reward) => reward > state.points,
      orElse: () => rewards.last,
    );
    return nextReward;
  }

  double getProgressPercentage() {
    final nextReward = getNextRewardPoints();
    final previousReward = _getPreviousReward(nextReward);
    final pointsInRange = state.points - previousReward;
    final range = nextReward - previousReward;
    return pointsInRange / range;
  }

  int _getPreviousReward(int currentReward) {
    const rewards = [0, 500, 1000, 1500, 2500];
    final index = rewards.indexOf(currentReward);
    return index > 0 ? rewards[index - 1] : 0;
  }

  String? getCurrentRewardName() {
    const rewards = {
      500: 'Free Drink',
      1000: 'Free Pupusa/Taco',
      1500: '\$10 Off',
      2500: 'Family Meal',
    };

    final points = state.points;
    final reward = rewards.keys.where((key) => key <= points).lastOrNull;
    return reward != null ? rewards[reward] : null;
  }

  String? getNextRewardName() {
    const rewards = {
      500: 'Free Drink',
      1000: 'Free Pupusa/Taco',
      1500: '\$10 Off',
      2500: 'Family Meal',
    };

    final nextReward = getNextRewardPoints();
    return rewards[nextReward];
  }

  void generateReferralCode() {
    if (state.referralCode == null) {
      final code = 'REF${DateTime.now().millisecondsSinceEpoch}'.substring(0, 10);
      state = state.copyWith(referralCode: code);
    }
  }
}