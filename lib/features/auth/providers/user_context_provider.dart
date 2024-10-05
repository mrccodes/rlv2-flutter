import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/providers/api_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';
import 'package:rlv2_flutter/features/auth/view_models/user_context_view_model.dart';

// UserSessionContextRepository provider
final userSessionContextRepositoryProvider = 
  Provider<UserSessionContextRepository>(
  (ref) {
    return UserSessionContextRepository(
      apiService: ref.watch(apiServiceProvider),
    );
  },
);

// FlutterSecureStorage provider
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

// UserSessionService provider
final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final userSessionRepository = ref.watch(userSessionContextRepositoryProvider);

  return UserSessionService(
    storage: storage,
    userSessionContextRepository: userSessionRepository,
  );
});

// UserSessionNotifier provider
final userContextSessionNotifierProvider =
    StateNotifierProvider<UserSessionNotifier, UserSessionState>((ref) {
  final userSessionService = ref.watch(userSessionServiceProvider);
  return UserSessionNotifier(service: userSessionService);
});

// Listen to AuthState and trigger loadUserSession on userId change
final userSessionListenerProvider = Provider<void>((ref) {
  ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    final previousUserId = previous?.user?.id;
    final nextUserId = next.user?.id;

    if (previousUserId != nextUserId && nextUserId != null) {
      ref
          .read(userContextSessionNotifierProvider.notifier)
          .loadUserSession(nextUserId);
    }
  });
});
