import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/providers/auth_service_provider.dart';
import 'package:rlv2_flutter/features/auth/notifiers/user_context_notifier.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

// provider
final userSessionContextServiceProvider = Provider<UserSessionContextService>(
  (ref) {
    return UserSessionContextService();
  },
);

final userContextSessionNotifierProvider =
    StateNotifierProvider<UserSessionNotifier, UserSessionState>((ref) {
  final userSessionContextService =
      ref.watch(userSessionContextServiceProvider);
  const storage = FlutterSecureStorage();
  return UserSessionNotifier(
    storage: storage,
    userSessionContextService: userSessionContextService,
  );
});

/// Listen to AuthState and trigger loadUserSession on userId change
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
