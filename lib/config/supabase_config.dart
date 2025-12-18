import 'package:supabase_flutter/supabase_flutter.dart';
import 'env.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      debug: true, // Set to false in production
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}