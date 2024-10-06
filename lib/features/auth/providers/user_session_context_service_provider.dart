// UserSessionService provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_repository_provider.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

final userSessionContextServiceProvider =
    Provider<UserSessionContextService>((ref) {
  final userSessionRepository = ref.watch(userSessionContextRepositoryProvider);

  return UserSessionContextService(
    userSessionContextRepository: userSessionRepository,
  );
});
