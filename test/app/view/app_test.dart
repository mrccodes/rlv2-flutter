import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_service_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/landing_screen.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';
import 'package:rlv2_flutter/features/user/providers/user_provider.dart';
import '../../helpers/test_setup.dart';
import '../../mocks/auth_notifier.dart';
import '../../mocks/user_notifier.dart';
import '../../mocks/user_session_context_service.dart';

// Mock the necessary providers for the test

void main() {
  group('App', () {
    setUpAll(testSetup);
    testWidgets('renders Landing Screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(LandingScreen), findsOneWidget);
    });

    testWidgets('App navigates to Login Screen on login button tap',
        (tester) async {
      // Mock AuthNotifier
      final mockAuthNotifier = MockAuthNotifier();
      final mockUserNotifier = MockUserNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => mockAuthNotifier),
            userProvider.overrideWith((ref) => mockUserNotifier),
            userSessionContextServiceProvider.overrideWithValue(
              MockUserSessionService(),
            ), // Mock the session repository
          ],
          child: const MaterialApp(home: LandingScreen()),
        ),
      );

      await tester.pumpAndSettle();
      // Verify the LandingScreen is rendered
      // expect(find.text('Go to Login'), findsOneWidget);

      // Simulate button tap to navigate to LoginScreen
      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pumpAndSettle();

      // Verify the LoginScreen is shown
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
