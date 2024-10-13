import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_provider.dart';
import 'package:rlv2_flutter/features/organization/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/features/organization/utils/personal_recipes_dummy_org.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class OrgSelect extends ConsumerWidget {
  const OrgSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    // Define a dropdown menu item for personal recipes
    final personalRecipes = DropdownMenuItem<String>(
      value: personalRecipesDummyOrg.id,
      child: Text(l10n.personalRecipesOrgDropdownLabel),
    );
    final userOrganizations = ref.watch(userOrganizationsProvider);
    final organizations = ref.watch(organizationProvider);
    final orgNotifier = ref.read(organizationProvider.notifier);
    final orgOptions = userOrganizations.data.map((org) {
      return DropdownMenuItem<String>(
        value: org.organizationId,
        child: Text(org.organizationName),
      );
    }).toList();

    if (userOrganizations.isLoading) {
      return const CircularProgressIndicator();
    }

    if (userOrganizations.error != null) {
      return Text(userOrganizations.error!);
    }

    // If user has no organizations, return an empty SizedBox
    if (orgOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    Future<void> updateSelectedOrganization(String orgId) async {
      if (orgId == personalRecipesDummyOrg.id) {
        orgNotifier.selectOrganization(personalRecipesDummyOrg);
        return;
      }
      // fetch and select the organization
      final selectedOrg = await orgNotifier.fetchOrganization(orgId);
      orgNotifier.selectOrganization(selectedOrg);
    }

    // Insert personal recipes at the beginning of the list
    orgOptions.insert(0, personalRecipes);

    final selectedOrgId =
        organizations.selectedOrganization?.id ?? personalRecipes.value;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      child: organizations.isLoading
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const LoadingWidget(),
            )
          : DropdownButtonFormField<String>(
              value: selectedOrgId,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              items: orgOptions,
              onChanged: (String? val) => {
                if (val != null &&
                    val != organizations.selectedOrganization?.id)
                  {
                    updateSelectedOrganization(val),
                  },
              },
              isExpanded: true, // Ensures the dropdown takes full width
            ),
    );
  }
}
