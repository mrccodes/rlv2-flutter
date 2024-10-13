import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_provider.dart';
import 'package:rlv2_flutter/features/dashboard/utils/get_category_list_from_user_recipes_with_data.dart';
import 'package:rlv2_flutter/features/dashboard/widgets/category_select.dart';
import 'package:rlv2_flutter/features/dashboard/widgets/org_select.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_nav_drawer.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_provider.dart';
import 'package:rlv2_flutter/features/organization/utils/personal_recipes_dummy_org.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_recipes_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final userInformation = ref.watch(userInformationProvider);
    final firstName = userInformation.data?.firstName;
    final userRecipes = ref.watch(
      userRecipesProvider.select((state) => state.data),
    );
    final organization = ref.watch(organizationProvider);
    final selectedOrg = organization.selectedOrganization;

    Widget renderChild(Widget child) {
      if (userInformation.isLoading) {
        AppLogger.info('DashboardScreen waiting: Loading user information');
        return const Center(child: LoadingWidget());
      }

      if (organization.isLoading) {
        AppLogger.info('DashboardScreen waiting: Loading organization');
        return const Center(child: LoadingWidget());
      }

      return child;
    }

    final categories = getCategoryListFromUserRecipesWithData(
      userRecipes,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title:
            selectedOrg != null && selectedOrg.id != personalRecipesDummyOrg.id
                ? '${selectedOrg.name} Dashboard'
                : 'Dashboard',
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
              child: renderChild(
                Column(
                  children: [
                    const OrgSelect(),
                    const SizedBox(height: 8),
                    CategorySelector(
                      categories: categories,
                    ),
                    Text(
                      'Hello${firstName != null ? ' $firstName' : ''}!',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
