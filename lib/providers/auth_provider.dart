import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_service.dart';
import '../models/app_user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AppUser?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AppUser?> {
  final _supabaseService = SupabaseService();

  AuthNotifier() : super(null);

  Future<void> signInWithEmail(String email, String password) async {
    try {
      // Mock authentication
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful login
      state = AppUser(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now().toIso8601String(), // FIXED: Use toIso8601String()
        loyaltyPoints: 500,
      );
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  Future<void> signUp(String email, String password, String name, String phone) async {
    try {
      // Mock registration
      await Future.delayed(const Duration(seconds: 1));

      state = AppUser(
        id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        phone: phone,
        createdAt: DateTime.now().toIso8601String(), // FIXED: Use toIso8601String()
        loyaltyPoints: 0,
        referralCode: 'REF${DateTime.now().millisecondsSinceEpoch}',
      );
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  Future<void> signOut() async {
    state = null;
  }

  Future<void> updateProfile(String name, String phone) async {
    if (state != null) {
      state = state!.copyWith(name: name, phone: phone);
    }
  }

  Future<void> loadCurrentUser() async {
    try {
      final user = await _supabaseService.getCurrentUser();
      state = user;
    } catch (e) {
      // Silently fail - user might not be logged in
      state = null;
    }
  }
}

// FIXED: Update copyWith to use String for createdAt
extension AppUserCopyWith on AppUser {
  AppUser copyWith({
    String? id,
    String? email,
    String? phone,
    String? name,
    String? createdAt, // FIXED: Changed from DateTime? to String?
    int? loyaltyPoints,
    String? referralCode,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt, // FIXED: Uses String
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      referralCode: referralCode ?? this.referralCode,
    );
  }
}