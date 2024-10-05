import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';

import 'user_session_context_repository.dart';

class MockUserSessionService extends UserSessionService {
  MockUserSessionService()
      : super(
          storage: const FlutterSecureStorage(),
          userSessionContextRepository: MockUserSessionContextRepository(),
        );
}
