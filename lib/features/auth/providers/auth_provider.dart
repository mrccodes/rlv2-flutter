import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/providers/api_provider.dart';
import 'package:rlv2_flutter/features/auth/repositories/auth_repository.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService: apiService); 
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(authRepository: authRepository, storage: storage);
});
