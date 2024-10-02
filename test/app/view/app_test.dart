import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/features/auth/screens/landing_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders Landing Screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(LandingScreen), findsOneWidget);
    });
  });
}
