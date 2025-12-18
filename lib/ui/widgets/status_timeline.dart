import 'package:flutter/material.dart';
import '../../config/theme.dart';

class StatusTimeline extends StatelessWidget {
  final String currentStatus;
  final List<String> statuses;
  final Map<String, DateTime?>? statusTimes; // Change to DateTime?

  const StatusTimeline({
    super.key,
    required this.currentStatus,
    this.statuses = const [
      'Received',
      'Preparing',
      'Ready',
      'Completed',
    ],
    this.statusTimes,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = statuses.indexOf(currentStatus);

    return Column(
      children: List.generate(statuses.length, (index) {
        final isActive = index <= currentIndex;
        final isLast = index == statuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline dot
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? AppTheme.spicyRed : AppTheme.lightGrey,
                    border: Border.all(
                      color: isActive ? AppTheme.spicyRed : AppTheme.charcoal.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: isActive
                      ? const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: isActive ? AppTheme.spicyRed : AppTheme.lightGrey,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Status info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statuses[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppTheme.spicyRed : AppTheme.charcoal.withOpacity(0.6),
                    ),
                  ),
                  if (statusTimes != null && statusTimes!.containsKey(statuses[index]))
                    Text(
                      statusTimes![statuses[index]] != null
                          ? _formatTime(statusTimes![statuses[index]]!)
                          : 'Pending',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.charcoal.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}