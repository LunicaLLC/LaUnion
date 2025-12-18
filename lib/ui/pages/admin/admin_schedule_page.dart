import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/admin_provider.dart';
import '../../../ui/layout/admin_scaffold.dart';
import '../../../ui/shared/app_button.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';

class AdminSchedulePage extends ConsumerStatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  ConsumerState<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends ConsumerState<AdminSchedulePage> {
  final List<Map<String, dynamic>> _schedule = [
    {
      'day': 'Monday',
      'locations': [
        {
          'address': '123 Main Street',
          'startTime': '11:00',
          'endTime': '20:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Tuesday',
      'locations': [
        {
          'address': '456 Park Avenue',
          'startTime': '11:00',
          'endTime': '20:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Wednesday',
      'locations': [
        {
          'address': '123 Main Street',
          'startTime': '11:00',
          'endTime': '20:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Thursday',
      'locations': [
        {
          'address': '789 Market Street',
          'startTime': '11:00',
          'endTime': '21:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Friday',
      'locations': [
        {
          'address': '123 Main Street',
          'startTime': '11:00',
          'endTime': '22:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Saturday',
      'locations': [
        {
          'address': '456 Park Avenue',
          'startTime': '10:00',
          'endTime': '22:00',
          'enabled': true,
        },
        {
          'address': '789 Market Street',
          'startTime': '12:00',
          'endTime': '23:00',
          'enabled': true,
        },
      ],
    },
    {
      'day': 'Sunday',
      'locations': [
        {
          'address': '123 Main Street',
          'startTime': '10:00',
          'endTime': '18:00',
          'enabled': true,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Schedule Management',
      actions: [
        IconButton(
          onPressed: _addLocation,
          icon: const Icon(Icons.add_location),
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Schedule',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              'Manage your truck locations and hours',
              style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
            ),
            const SizedBox(height: AppConstants.xl),
            ..._schedule.map((daySchedule) {
              return _buildDaySchedule(daySchedule);
            }),
            const SizedBox(height: AppConstants.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(Map<String, dynamic> daySchedule) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.lg),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  daySchedule['day'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: _isDayEnabled(daySchedule),
                  onChanged: (value) {
                    _toggleDay(daySchedule, value);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppConstants.md),
            if (_isDayEnabled(daySchedule))
              ...(daySchedule['locations'] as List).map((location) {
                return _buildLocationRow(location, daySchedule['day']);
              })
            else
              const Text(
                'Closed',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            if (_isDayEnabled(daySchedule))
              Padding(
                padding: const EdgeInsets.only(top: AppConstants.md),
                child: AppButton(
                  text: 'Add Location',
                  onPressed: () => _addLocationToDay(daySchedule),
                  primary: false,
                  icon: Icons.add,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(Map<String, dynamic> location, String day) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location['address'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${location['startTime']} - ${location['endTime']}',
                  style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _editLocation(location, day),
                icon: const Icon(Icons.edit, size: 20),
              ),
              IconButton(
                onPressed: () => _deleteLocation(location, day),
                icon: const Icon(Icons.delete, size: 20),
                color: AppTheme.spicyRed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isDayEnabled(Map<String, dynamic> daySchedule) {
    final locations = daySchedule['locations'] as List;
    return locations.isNotEmpty &&
        locations.any((loc) => loc['enabled'] == true);
  }

  void _toggleDay(Map<String, dynamic> daySchedule, bool enabled) {
    setState(() {
      final locations = daySchedule['locations'] as List;
      for (var location in locations) {
        location['enabled'] = enabled;
      }
    });
  }

  void _addLocation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Location'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Feature coming soon!'),
            SizedBox(height: AppConstants.md),
            Text('You can add new locations in the next update.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _addLocationToDay(Map<String, dynamic> daySchedule) {
    // Implementation for adding location to specific day
  }

  void _editLocation(Map<String, dynamic> location, String day) {
    showDialog(
      context: context,
      builder: (context) => _LocationDialog(
        location: location,
        day: day,
        onSave: (updatedLocation) {
          // Update location logic
        },
      ),
    );
  }

  void _deleteLocation(Map<String, dynamic> location, String day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Location'),
        content: Text('Remove ${location['address']} from $day?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete location logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.spicyRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _LocationDialog extends StatefulWidget {
  final Map<String, dynamic> location;
  final String day;
  final Function(Map<String, dynamic>) onSave;

  const _LocationDialog({
    required this.location,
    required this.day,
    required this.onSave,
  });

  @override
  State<_LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<_LocationDialog> {
  final _addressController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.location['address'];
    _startTimeController.text = widget.location['startTime'];
    _endTimeController.text = widget.location['endTime'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Location for ${widget.day}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _startTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                    border: OutlineInputBorder(),
                    hintText: 'HH:MM',
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: TextFormField(
                  controller: _endTimeController,
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                    border: OutlineInputBorder(),
                    hintText: 'HH:MM',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedLocation = {
              ...widget.location,
              'address': _addressController.text,
              'startTime': _startTimeController.text,
              'endTime': _endTimeController.text,
            };
            widget.onSave(updatedLocation);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
