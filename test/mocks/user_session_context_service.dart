import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

import 'user_session_context_repository.dart';

class MockUserSessionService extends UserSessionContextService {
  MockUserSessionService()
      : super(
          userSessionContextRepository: MockUserSessionContextRepository(),
        );
}
