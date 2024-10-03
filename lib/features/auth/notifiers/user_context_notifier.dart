import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';
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
    required this.storage,
    required this.userSessionContextService,
  }) : super(UserSessionState());

  final FlutterSecureStorage storage;
  final UserSessionContextService userSessionContextService;

  Future<void> loadUserSession(String userId) async {
    try {
      AppLogger.info('Loading user session for user: $userId');
      state = UserSessionState(isLoading: true);

      // Reading session from storage
      final jsonString = await storage.read(key: 'userSession');
      AppLogger.info('User session jsonString: $jsonString');

      UserSessionContext userSessionContext;

      AppLogger.info('Fetching user session context for user: $userId');
      userSessionContext =
          await userSessionContextService.getUserSessionContext(userId: userId);

      // Update the state with the loaded session data
      state = UserSessionState(userSessionContext: userSessionContext);
      AppLogger.info('State updated with user session data');
    } catch (e, stackTrace) {
      AppLogger.error('Error loading user session: $e');
      AppLogger.error('Stack trace: $stackTrace');
      state = UserSessionState(error: e.toString());
    }
  }

  Future<void> saveUserSession(UserSessionContext context) async {
    try {
      final jsonString = jsonEncode(context.toJson());
      await storage.write(key: 'userSession', value: jsonString);

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
      await storage.delete(key: 'userSession');
      state = UserSessionState();
      AppLogger.info('User session cleared from storage');
    } catch (e, stackTrace) {
      AppLogger.error('Error clearing user session: $e');
      AppLogger.error('Stack trace: $stackTrace');
      state = UserSessionState(error: e.toString());
    }
  }
}
