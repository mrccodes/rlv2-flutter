import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';

import 'api_service.dart';
class MockUserSessionContextRepository extends UserSessionContextRepository {
  MockUserSessionContextRepository() : super(apiService: MockApiService() );
}
