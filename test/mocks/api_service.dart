import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';
import 'constants.dart';

// Step 1: Create a MockApiService class
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late UserSessionContextRepository repository;

  setUp(() {
    mockApiService = MockApiService();
    repository = UserSessionContextRepository(apiService: mockApiService);
  });

  test('fetchUserSessionContext returns a valid UserSessionContext', () async {
    final mockUserSessionContext = UserSessionContext(
      user: testUser,
      userSettings: testUserSettings,
      userFavoriteRecipes: [],
      userInformation: testUserInformation,
      userOrganizations: [],
      userRecipes: [],
      subscriptions: [],
    );

    // Simulate a successful API response
    when(
      () => mockApiService.getRequest<UserSessionContext>(
        any(),
        any(),
      ),
    ).thenAnswer(
      (_) async => mockUserSessionContext,
    );

    final result = await repository.getUserSessionContext(userId: 'user123');

    expect(result, equals(mockUserSessionContext));
    verify(
      () => mockApiService.getRequest<UserSessionContext>(
        '/user-session/user123',
        UserSessionContext.fromJson,
      ),
    ).called(1);
  });
}
