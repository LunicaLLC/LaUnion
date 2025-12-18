
class TruckLocation {
  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime startTime;
  final DateTime endTime;
  final DayOfWeek dayOfWeek;

  TruckLocation({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
  });

  bool get isCurrentlyOpen {
    final now = DateTime.now();
    return now.isAfter(startTime) &&
        now.isBefore(endTime) &&
        now.weekday == dayOfWeek.index + 1;
  }

  factory TruckLocation.fromJson(Map<String, dynamic> json) {
    return TruckLocation(
      id: json['id'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      dayOfWeek: DayOfWeek.values[json['day_of_week']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'day_of_week': dayOfWeek.index,
    };
  }
}

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

// Extension for DayOfWeek utilities
extension DayOfWeekExtension on DayOfWeek {
  String get name {
    switch (this) {
      case DayOfWeek.monday:
        return 'Monday';
      case DayOfWeek.tuesday:
        return 'Tuesday';
      case DayOfWeek.wednesday:
        return 'Wednesday';
      case DayOfWeek.thursday:
        return 'Thursday';
      case DayOfWeek.friday:
        return 'Friday';
      case DayOfWeek.saturday:
        return 'Saturday';
      case DayOfWeek.sunday:
        return 'Sunday';
    }
  }

  String get abbreviation {
    switch (this) {
      case DayOfWeek.monday:
        return 'Mon';
      case DayOfWeek.tuesday:
        return 'Tue';
      case DayOfWeek.wednesday:
        return 'Wed';
      case DayOfWeek.thursday:
        return 'Thu';
      case DayOfWeek.friday:
        return 'Fri';
      case DayOfWeek.saturday:
        return 'Sat';
      case DayOfWeek.sunday:
        return 'Sun';
    }
  }
}