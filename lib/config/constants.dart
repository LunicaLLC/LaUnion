class AppConstants {
  // Spacing system (8px grid)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Animation durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Loyalty program
  static const int pointsPerDollar = 10;
  static const Map<int, String> rewards = {
    500: 'Free Drink',
    1000: 'Free Pupusa/Taco',
    1500: '\$10 Off',
    2500: 'Family Meal',
  };

  // Default pickup time buffer (in minutes)
  static const int pickupBufferMinutes = 15;

  // Feature flags
  static const bool useMockData = true;
}
