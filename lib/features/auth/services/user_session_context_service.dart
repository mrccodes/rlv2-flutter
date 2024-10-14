import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';

class UserSessionContextService {
  UserSessionContextService({
    required this.userSessionContextRepository,
  });

  final UserSessionContextRepository userSessionContextRepository;

  Future<UserSessionContext> fetchUserSessionContext() async {
    try {
      final userSessionContext =
          await userSessionContextRepository.getUserSessionContext();
      return userSessionContext!;
    } catch (e) {
      rethrow;
    }
  }
}
