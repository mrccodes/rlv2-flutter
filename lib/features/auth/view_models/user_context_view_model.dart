import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

// UserSessionState holds the state of UserSessionContext
class UserSessionState {
  UserSessionState({
    this.userSessionContext,
    this.isLoading = false,
    this.error,
  });

  final UserSessionContext? userSessionContext;
  final bool isLoading;
  final String? error;
}

class UserSessionNotifier extends StateNotifier<UserSessionState> {
  UserSessionNotifier({
    required this.repository,
  }) : super(UserSessionState());

  final UserSessionRepository repository;

  Future<void> loadUserSession(String userId) async {
    try {
      AppLogger.info('Loading user session for user: $userId');
      state = UserSessionState(isLoading: true);

      final userSessionContext = await repository.fetchUserSessionContext(userId);

      state = UserSessionState(userSessionContext: userSessionContext);
      AppLogger.info('State updated with user session data $userSessionContext');
    } catch (e, stackTrace) {
      AppLogger.error('Error loading user session: $e');
      AppLogger.error('Stack trace: $stackTrace');
      state = UserSessionState(error: e.toString());
    }
  }

  Future<void> saveUserSession(UserSessionContext context) async {
    try {
      await repository.saveUserSessionContext(context); 
      state = UserSessionState(userSessionContext: context);
      AppLogger.info('User session saved to storage');
    } catch (e, stackTrace) {
      AppLogger.error('Error saving user session: $e');
      AppLogger.error('Stack trace: $stackTrace');
      state = UserSessionState(error: e.toString());
    }
  }

  Future<void> clearUserSession() async {
    try {
      await repository.clearUserSessionContext(); 
      state = UserSessionState();
      AppLogger.info('User session cleared from storage');
    } catch (e, stackTrace) {
      AppLogger.error('Error clearing user session: $e');
      AppLogger.error('Stack trace: $stackTrace');
      state = UserSessionState(error: e.toString());
    }
  }
}
