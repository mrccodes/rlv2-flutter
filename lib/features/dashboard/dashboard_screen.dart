import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/dashboard_provider.dart';
import 'package:rlv2_flutter/core/providers/scaffold_provider.dart';
import 'package:rlv2_flutter/core/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/core/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/core/widgets/custom_nav_drawer.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final dashboardViewModel = ref.read(dashboardViewModelProvider.notifier);
    final scaffoldKey = ref.watch(scaffoldKeyProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'RecipeLab',
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: dashboardState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardState.errorMessage.isNotEmpty
              ? Center(child: Text(dashboardState.errorMessage))
              : Center(
                child:    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello${
                        dashboardState.firstName != '' ? 
                        ' ${dashboardState.firstName}' : ''}!',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: dashboardViewModel.loadDashboardData,
                      child: const Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
           
    );
  }
}
