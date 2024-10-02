import 'package:flutter/material.dart'; // Ensure you import material
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/core/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/core/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_screen.dart';

void main() {
  group('DashboardScreen', () {
    testWidgets('renders primary nav components', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
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
