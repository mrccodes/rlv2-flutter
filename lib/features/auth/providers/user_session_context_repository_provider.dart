// UserSessionContextRepository provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';

final userSessionContextRepositoryProvider =
    Provider<UserSessionContextRepository>(
  (ref) {
    return UserSessionContextRepository(
      apiService: ref.watch(apiServiceProvider),
    );
  },
);
