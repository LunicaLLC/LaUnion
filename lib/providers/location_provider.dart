import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/truck_location.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, List<TruckLocation>>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<List<TruckLocation>> {
  final _apiService = ApiService();
  TruckLocation? _currentLocation;

  LocationNotifier() : super([]);

  Future<void> loadLocations() async {
    try {
      // Mock data
      await Future.delayed(const Duration(seconds: 1));

      state = [
        TruckLocation(
          id: 'loc_001',
          address: '123 Main Street, Downtown',
          latitude: 40.7128,
          longitude: -74.0060,
          startTime: DateTime.now().subtract(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 6)),
          dayOfWeek: DayOfWeek.values[DateTime.now().weekday - 1],
        ),
        TruckLocation(
          id: 'loc_002',
          address: '456 Park Avenue, Uptown',
          latitude: 40.7589,
          longitude: -73.9851,
          startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
          endTime: DateTime.now().add(const Duration(days: 1, hours: 16)),
          dayOfWeek: DayOfWeek.values[(DateTime.now().weekday) % 7],
        ),
      ];

      _currentLocation = state.firstWhere(
            (loc) => loc.isCurrentlyOpen,
        orElse: () => state.isNotEmpty ? state.first : throw Exception('No locations'),
      );
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }

  TruckLocation? get currentLocation => _currentLocation;

  List<TruckLocation> getTodayLocations() {
    final today = DateTime.now().weekday - 1;
    return state.where((loc) => loc.dayOfWeek.index == today).toList();
  }

  List<TruckLocation> getUpcomingLocations() {
    final now = DateTime.now();
    return state.where((loc) => loc.startTime.isAfter(now)).toList();
  }

  Future<void> setCurrentLocation(TruckLocation location) async {
    _currentLocation = location;
  }
}