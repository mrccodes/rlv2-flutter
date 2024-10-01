import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_screen.dart';

import '../../helpers/test_setup.dart';

void main() {
  group('App', () {
        setUpAll(() async {
      await testSetup();
    });

    testWidgets('renders DashboardScreen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(DashboardScreen), findsOneWidget);
    });
  });
}
