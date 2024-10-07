import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_service_provider.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/user/providers/user_provider.dart';
import '../../helpers/test_setup.dart';
import '../../mocks/auth_notifier.dart';
import '../../mocks/user_notifier.dart';
import '../../mocks/user_session_context_service.dart';

void main() {
  group('DashboardScreen', () {
    setUpAll(testSetup);
    testWidgets('renders primary nav components', (tester) async {
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
          child: const App(),
        ),
      );
      await mockAuthNotifier.login('test', 'test');
      await tester.pumpAndSettle();
      // Check for presence of CustomAppBar and CustomBottomNavigationBar
      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(CustomBottomNavigationBar), findsOneWidget);
    });
  });
}
