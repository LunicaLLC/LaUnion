import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../models/truck_location.dart';
import '../../../providers/location_provider.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../shared/app_card.dart';
import '../../widgets/location_widget.dart';

class TruckMapPage extends ConsumerStatefulWidget {
  const TruckMapPage({super.key});

  @override
  ConsumerState<TruckMapPage> createState() => _TruckMapPageState();
}

class _TruckMapPageState extends ConsumerState<TruckMapPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider.notifier).loadLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locations = ref.watch(locationProvider);
    final currentLocation = ref.read(locationProvider.notifier).currentLocation;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.lightGrey,
              border: Border.all(color: AppTheme.lightGrey),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 48, color: AppTheme.spicyRed),
                  const SizedBox(height: AppConstants.md),
                  Text(l10n.interactiveMap),
                  Text(
                    l10n.googleMapsIntegration,
                    style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.xl),
          // Current location
          if (currentLocation != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.currentLocationUppercase,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.citrusOrange,
                  ),
                ),
                const SizedBox(height: AppConstants.md),
                LocationWidget(
                  address: currentLocation.address,
                  openTime: currentLocation.startTime,
                  closeTime: currentLocation.endTime,
                  onNotify: () {
                    // Subscribe to notifications
                    _subscribeToNotifications();
                  },
                  onNavigate: () {
                    // Open in maps app
                    _openInMaps(currentLocation);
                  },
                ),
                const SizedBox(height: AppConstants.xl),
              ],
            ),
          // Schedule
          Text(
            l10n.weeklyScheduleUppercase,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.citrusOrange),
          ),
          const SizedBox(height: AppConstants.md),
          ...locations.map((location) {
            return _buildScheduleCard(location, context);
          }),
          const SizedBox(height: AppConstants.xl),
          // Notifications section
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_active, color: AppTheme.spicyRed),
                    const SizedBox(width: AppConstants.md),
                    Text(
                      l10n.getNotified,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  l10n.getNotifiedDescription,
                  style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                ),
                const SizedBox(height: AppConstants.lg),
                ElevatedButton(
                  onPressed: _subscribeToNotifications,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.spicyRed,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(l10n.enableNotifications),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(TruckLocation location, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Row(
          children: [
            // Day indicator
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: location.isCurrentlyOpen
                    ? AppTheme.avocadoGreen
                    : AppTheme.lightGrey,
              ),
              child: Center(
                child: Text(
                  _getDayAbbreviation(context, location.dayOfWeek),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: location.isCurrentlyOpen
                        ? Colors.white
                        : AppTheme.charcoal,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.md),
            // Location info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDayName(context, location.dayOfWeek),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.address,
                    style: TextStyle(color: AppTheme.charcoal.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${Formatters.formatTime(location.startTime)} - ${Formatters.formatTime(location.endTime)}',
                    style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            // Status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: location.isCurrentlyOpen
                    ? AppTheme.avocadoGreen.withOpacity(0.1)
                    : AppTheme.lightGrey,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: location.isCurrentlyOpen
                      ? AppTheme.avocadoGreen
                      : AppTheme.charcoal.withOpacity(0.3),
                ),
              ),
              child: Text(
                location.isCurrentlyOpen
                    ? AppLocalizations.of(context)!.statusOpen
                    : AppLocalizations.of(context)!.statusClosed,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: location.isCurrentlyOpen
                      ? AppTheme.avocadoGreen
                      : AppTheme.charcoal.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayAbbreviation(BuildContext context, DayOfWeek day) {
    final l10n = AppLocalizations.of(context)!;
    switch (day) {
      case DayOfWeek.monday:
        return l10n.mondayAbbr;
      case DayOfWeek.tuesday:
        return l10n.tuesdayAbbr;
      case DayOfWeek.wednesday:
        return l10n.wednesdayAbbr;
      case DayOfWeek.thursday:
        return l10n.thursdayAbbr;
      case DayOfWeek.friday:
        return l10n.fridayAbbr;
      case DayOfWeek.saturday:
        return l10n.saturdayAbbr;
      case DayOfWeek.sunday:
        return l10n.sundayAbbr;
    }
  }

  String _getDayName(BuildContext context, DayOfWeek day) {
    final l10n = AppLocalizations.of(context)!;
    switch (day) {
      case DayOfWeek.monday:
        return l10n.monday;
      case DayOfWeek.tuesday:
        return l10n.tuesday;
      case DayOfWeek.wednesday:
        return l10n.wednesday;
      case DayOfWeek.thursday:
        return l10n.thursday;
      case DayOfWeek.friday:
        return l10n.friday;
      case DayOfWeek.saturday:
        return l10n.saturday;
      case DayOfWeek.sunday:
        return l10n.sunday;
    }
  }

  void _subscribeToNotifications() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.getNotificationsDialogTitle),
        content: Text(l10n.enterPhoneNumberNotification),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.notificationsEnabled),
                  backgroundColor: AppTheme.avocadoGreen,
                ),
              );
            },
            child: Text(l10n.subscribe),
          ),
        ],
      ),
    );
  }

  void _openInMaps(TruckLocation location) {
    // In a real app, this would open the maps app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.openingInMaps(location.address),
        ),
        backgroundColor: AppTheme.avocadoGreen,
      ),
    );
  }
}
