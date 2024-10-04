import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';

final authProvider = Provider<AuthService>((ref) {
  return AuthService(); // Replace with your API base URL
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(authService: authService, storage: storage);
});