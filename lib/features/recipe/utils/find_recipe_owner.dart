import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/user/utils/get_display_name.dart';

String findRecipeOwner(RecipeWithData recipe, WidgetRef ref) {
  if (recipe.organizationId != null) {
    final org = ref
        .read(userOrganizationsProvider)
        .data
        .cast<OrganizationUser?>()
        .firstWhere(
          (org) => org?.organizationId == recipe.organizationId,
          orElse: () => null,
        );

    return org?.organizationName ?? '';
  } else {
    return getDisplayName(ref);
  }
}
