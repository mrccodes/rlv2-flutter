import 'package:flutter/material.dart'; // Ensure you import material
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_context_provider.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_screen.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';

import '../../helpers/test_setup.dart';
import '../../mocks/auth_notifier.dart';
import '../../mocks/user_session_context_service.dart';

void main() {
  group('DashboardScreen', () {
    setUpAll(testSetup);
    testWidgets('renders primary nav components', (tester) async {
      final mockAuthNotifier = MockAuthNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith((ref) => mockAuthNotifier),
            userSessionServiceProvider.overrideWithValue(
              MockUserSessionService(),
            ), // Mock the session repository
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Check for presence of CustomAppBar and CustomBottomNavigationBar
      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(CustomBottomNavigationBar), findsOneWidget);
    });
  });
}
