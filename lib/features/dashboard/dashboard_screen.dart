import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_provider.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final userSessionContextState = ref.watch(userSessionContextProvider);
    final firstName =
        userSessionContextState.userSessionContext?.userInformation?.firstName;

    return SharedScaffold(
      appBarTitle: 'Dashboard',
      body: userSessionContextState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardState.errorMessage.isNotEmpty ||
                  userSessionContextState.error != null
              ? Center(
                  child: Text(
                    dashboardState.errorMessage.isNotEmpty
                        ? dashboardState.errorMessage
                        : userSessionContextState.error!,
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
