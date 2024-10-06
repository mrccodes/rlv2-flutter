import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final user = ref.watch(userProvider);
    final userInformation = ref.watch(userInformationProvider);
    final firstName = userInformation.data?.firstName;

    if (user.data == null) {
      AppLogger.error('User is null');
      return const Center(child: CircularProgressIndicator());
    }

    return SharedScaffold(
      appBarTitle: 'Dashboard',
      body: dashboardState.errorMessage.isNotEmpty
          ? Center(
              child: Text(
                dashboardState.errorMessage,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello${firstName != null ? ' $firstName' : ''}!',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
