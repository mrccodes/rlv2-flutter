import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

import 'constants.dart';
import 'user_session_context_repository.dart';

class MockUserSessionService extends UserSessionContextService {
  MockUserSessionService()
      : super(
          userSessionContextRepository: MockUserSessionContextRepository(),
        );

  @override
  Future<UserSessionContext> fetchUserSessionContext(String userId) async {
    return Future.value(testUserSessionContext);
  }
}
