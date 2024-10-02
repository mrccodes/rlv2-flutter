import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/features/auth/screens/landing_screen.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';


// Mock AuthState

// In your test

void main() {


  group('App', () {
    testWidgets('renders Landing Screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(LandingScreen), findsOneWidget);
    });

    testWidgets('navigates to Login Screen on login button tap',
        (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await tester.pumpAndSettle(); // Wait for navigation to complete
      // Simulate tapping the login button
      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pumpAndSettle(); // Wait for navigation to complete

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
