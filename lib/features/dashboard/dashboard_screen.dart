import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/dashboard_provider.dart';
import 'package:rlv2_flutter/core/providers/scaffold_provider.dart';
import 'package:rlv2_flutter/core/providers/user_context_provider.dart';
import 'package:rlv2_flutter/core/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/core/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/core/widgets/custom_nav_drawer.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final scaffoldKey = ref.watch(scaffoldKeyProvider);
    final userSessionContextState = ref.watch(userContextSessionNotifierProvider);


    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'RecipeLab',
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(),

      body: userSessionContextState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardState.errorMessage.isNotEmpty || 
            userSessionContextState.error != null
              ? Center(child: Text(dashboardState.errorMessage.isNotEmpty ? 
                dashboardState.errorMessage : 
                userSessionContextState.error!,
                ),
              )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello${userSessionContextState.userSessionContext?.userInformation?.firstName ??
      ''}!',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                       const Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                ),
    );
  }
}
