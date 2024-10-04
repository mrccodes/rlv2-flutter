import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';
import 'package:rlv2_flutter/features/auth/view_models/user_context_view_model.dart';

// UserSessionContextService provider
final userSessionContextServiceProvider = Provider<UserSessionContextService>(
  (ref) {
    return UserSessionContextService();
  },
);

// FlutterSecureStorage provider
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(), 
);

// UserSessionRepository provider
final userSessionRepositoryProvider = Provider<UserSessionRepository>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final userSessionContextService = ref.watch(userSessionContextServiceProvider);
  return UserSessionRepository(
    storage: storage,
    userSessionContextService: userSessionContextService,
  );
});

// Update the UserContextSessionNotifier provider to use the repository
final userContextSessionNotifierProvider =
    StateNotifierProvider<UserSessionNotifier, UserSessionState>((ref) {
  final userSessionRepository = ref.watch(userSessionRepositoryProvider); 
  return UserSessionNotifier(repository: userSessionRepository);
});

// Listen to AuthState and trigger loadUserSession on userId change
final userSessionListenerProvider = Provider<void>((ref) {
  // Listen for changes in AuthState
  ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    final previousUserId = previous?.user?.id;
    final nextUserId = next.user?.id;
    // Check if userId has changed
    if (previousUserId != nextUserId && nextUserId != null) {
      // Call loadUserSession with the new userId
      ref
          .read(userContextSessionNotifierProvider.notifier)
          .loadUserSession(nextUserId);
    }
  });
});
