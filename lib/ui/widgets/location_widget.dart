import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/formatters.dart';

class LocationWidget extends StatelessWidget {
  final String address;
  final DateTime openTime;
  final DateTime closeTime;
  final VoidCallback onNotify;
  final VoidCallback onNavigate;

  const LocationWidget({
    super.key,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.onNotify,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = _isCurrentlyOpen();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOpen ? AppTheme.avocadoGreen : AppTheme.lightGrey,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: isOpen ? AppTheme.avocadoGreen : AppTheme.charcoal,
              ),
              const SizedBox(width: 8),
              Text(
                isOpen ? 'OPEN NOW' : 'CLOSED',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? AppTheme.avocadoGreen : AppTheme.spicyRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            address,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '${Formatters.formatTime(openTime)} - ${Formatters.formatTime(closeTime)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.charcoal.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onNotify,
                  icon: const Icon(Icons.notifications),
                  label: const Text('Notify Me'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.citrusOrange),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onNavigate,
                  icon: const Icon(Icons.directions),
                  label: const Text('Navigate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.citrusOrange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isCurrentlyOpen() {
    final now = DateTime.now();
    return now.isAfter(openTime) && now.isBefore(closeTime);
  }
}