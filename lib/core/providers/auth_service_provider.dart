import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';

// Provide the AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(); // Replace with your API base URL
});

// Authentication State
class AuthState {
  AuthState({this.user, this.isLoading = false, this.error});
  final User? user;
  final bool isLoading;
  final String? error;
}

// StateNotifier to manage AuthState
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.authService, required this.storage})
      : super(AuthState());
  final AuthService authService;
  final FlutterSecureStorage storage;

  Future<void> login(String email, String password) async {
    try {
      state = AuthState(isLoading: true);
      final user = await authService.login(email: email, password: password);
      state = AuthState(user: user);
      // Optionally, store token or user info securely
      await storage.write(key: 'user_id', value: user.id);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  // Add logout and other methods as needed
  Future<void> logout() async {
    await storage.delete(key: 'user_id');
    state = AuthState();
  }
}

// Provide the AuthNotifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(authService: authService, storage: storage);
});
