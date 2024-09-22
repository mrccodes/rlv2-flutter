import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/dashboard/dashboard_page.dart';

void main() {
  group('App', () {
    testWidgets('renders DashboardPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardPage), findsOneWidget);
    });
  });
}
