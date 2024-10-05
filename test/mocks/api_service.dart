import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rlv2_flutter/core/models/api_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/user_session_context_repository.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';

// Step 1: Create a MockApiService class
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late UserSessionContextRepository repository;

  setUp(() {
    // Step 2: Initialize the mock and the repository
    mockApiService = MockApiService();
    repository = UserSessionContextRepository(apiService: mockApiService);
  });

  test('fetchUserSessionContext returns a valid UserSessionContext', () async {
    // Step 3: Define the behavior of the mock for this specific test case
    final mockUserSessionContext = UserSessionContext(
      user: User(
        id: 'test-id', 
        username: 'mrc', 
        email: 'matt@matt.com', 
        password: 'password', 
        stripeCustomerId: 'stripe-id', 
        createdAt: '111111', 
        updatedAt: '111111',
        ),
        userSettings: UserSettings(
          userId: 'test-id', 
          notifications: false, 
          pushNotifications: false, 
          emailNotifications: false, 
          newsletter: false, 
          dataSharingConsent: false, 
          showTipsAndTricks: false, 
          createdAt: '11111', 
          updatedAt: '111111',
          ),
        userFavoriteRecipes: [],
        userInformation: UserInformation(
          createdAt: '1111111', 
          updatedAt: '111111', 
          firstName: 'matt', 
          lastName: 'matt', 
          image: null, 
          bio: 'Test bio',
          ),

        organizationUsers: [],
        userRecipes: [],
        subscriptions: [],
    );

    // Simulate a successful API response
    when(() => mockApiService.getRequest<UserSessionContext>(
          any(),
          any(),
        ),
        ).thenAnswer(
      (_) async => ApiResponse.success(
        mockUserSessionContext,
        'Success',
        200,
      ),
    );

    // Step 4: Call the method you want to test
    final result = await repository.getUserSessionContext(userId: 'user123');

    // Step 5: Verify the result
    expect(result, equals(mockUserSessionContext));
    verify(() => mockApiService.getRequest<UserSessionContext>(
          '/user-session/user123',
          UserSessionContext.fromJson,
        )).called(1);
  });

  // Additional tests can go here...
}
