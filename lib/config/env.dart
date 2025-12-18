class Env {
  static late String supabaseUrl;
  static late String supabaseAnonKey;
  static late String stripePublishableKey;
  static late String googleMapsApiKey;

  static Future<void> load() async {
    // In production, load from environment variables
    // For development, use hardcoded values or .env file
    supabaseUrl = 'https://your-project.supabase.co';
    supabaseAnonKey = 'your-anon-key';
    stripePublishableKey = 'pk_test_...';
    googleMapsApiKey = 'AIza...';
  }
}