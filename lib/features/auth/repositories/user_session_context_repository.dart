import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

class UserSessionRepository {
  UserSessionRepository({
    required this.storage,
    required this.userSessionContextService,
  });

  final FlutterSecureStorage storage;
  final UserSessionContextService userSessionContextService;

  Future<UserSessionContext> fetchUserSessionContext(String userId) async {
    try {
      final userSessionContext =
          await userSessionContextService.getUserSessionContext(userId: userId);
      return userSessionContext!;
    } catch (e) {
      throw Exception('Error fetching user session: $e');
    }
  }

  Future<void> saveUserSessionContext(UserSessionContext context) async {
    final jsonString = jsonEncode(context.toJson());
    await storage.write(key: 'userSession', value: jsonString);
  }

  Future<void> clearUserSessionContext() async {
    await storage.delete(key: 'userSession');
  }
}
