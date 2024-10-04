import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';

import 'user_session_context_service.dart';

class MockUserSessionRepository extends UserSessionRepository {
  MockUserSessionRepository()
      : super(
          storage: const FlutterSecureStorage(),
          userSessionContextService: MockUserSessionContextService(),
        );
}
