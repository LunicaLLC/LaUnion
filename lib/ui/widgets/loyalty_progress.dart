import 'package:flutter/material.dart';
import '../../config/theme.dart';

class LoyaltyProgress extends StatelessWidget {
  final int currentPoints;
  final int nextRewardPoints;
  final String nextRewardName;

  const LoyaltyProgress({
    super.key,
    required this.currentPoints,
    required this.nextRewardPoints,
    required this.nextRewardName,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentPoints / nextRewardPoints;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.avocadoGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.avocadoGreen.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LOYALTY POINTS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.avocadoGreen,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '$currentPoints pts',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppTheme.lightGrey,
            color: AppTheme.avocadoGreen,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 pts',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.charcoal.withOpacity(0.6),
                ),
              ),
              Text(
                '$nextRewardPoints pts',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.avocadoGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$nextRewardPoints points: $nextRewardName',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.charcoal.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}