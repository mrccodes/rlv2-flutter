import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';

class UserSessionService {
  UserSessionService({
    required this.storage,
    required this.userSessionContextRepository,
  });

  final FlutterSecureStorage storage;
  final UserSessionContextRepository userSessionContextRepository;

  Future<UserSessionContext> fetchUserSessionContext(String userId) async {
    try {
      final userSessionContext =
          await userSessionContextRepository
            .getUserSessionContext(userId: userId);
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
