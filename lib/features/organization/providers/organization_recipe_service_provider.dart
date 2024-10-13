import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_recipe_repository_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_recipes_service.dart';

final organizationRecipesServiceProvider = 
  Provider<OrganizationRecipesService>((ref) {
  final organizationRecipesRepository = 
    ref.watch(organizationRecipeRepositoryProvider);
  return OrganizationRecipesService(
    organizationRecipesRepository: organizationRecipesRepository,
    );
});
