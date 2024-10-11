import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_provider.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_nav_drawer.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final userInformation = ref.watch(userInformationProvider);
    final firstName = userInformation.data?.firstName;

    if (userInformation.isLoading) {
      AppLogger.info('DashboardScreen waiting: Loading user information');
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Dashboard',
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
