import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/organization_model.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_provider.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_recipe_service_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_recipes_service.dart';
import 'package:rlv2_flutter/features/organization/utils/personal_recipes_dummy_org.dart';
import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_recipes_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class RecipeListState {
  RecipeListState({
    this.recipes = const <RecipeWithData>[],
    this.filteredRecipes = const <RecipeWithData>[],
    this.isLoading = false,
    this.error,
  });

  final List<RecipeWithData> recipes;
  final List<RecipeWithData> filteredRecipes;
  final bool isLoading;
  final String? error;

  RecipeListState copyWith({
    List<RecipeWithData>? recipes,
    List<RecipeWithData>? filteredRecipes,
    bool? isLoading,
    String? error,
  }) {
    return RecipeListState(
      recipes: recipes ?? this.recipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class RecipeListNotifier extends StateNotifier<RecipeListState> {
  RecipeListNotifier(
    OrganizationRecipesService organizationRecipeService,
    Ref ref,
  )   : _organizationRecipeService = organizationRecipeService,
        super(RecipeListState()) {
    // Listen to changes in selectedOrganization and fetch new recipes
    ref.listen<OrganizationState>(
      organizationProvider,
      (previous, next) async {
        if (next.selectedOrganization != previous?.selectedOrganization) {
          await _fetchRecipesForSelectedOrganization(
            next.selectedOrganization,
            ref,
          );
        }
      },
    );
  }

  final OrganizationRecipesService _organizationRecipeService;

  List<RecipeWithData> get recipes => state.recipes;

  List<RecipeWithData> updateRecipeList(List<RecipeWithData> newRecipes) {
    state = state.copyWith(recipes: newRecipes);
    return state.recipes;
  }

  List<RecipeWithData> filterByCategories(List<Category> categoryNames) {
    AppLogger.info('Filtering recipes by categories: $categoryNames');
    final filtered = state.recipes
        .where(
          (recipe) => recipe.versions.any(
            (ver) => ver.categories.any(
              (cat) => categoryNames.contains(cat),
            ),
          ),
        )
        .toList();
    state = state.copyWith(filteredRecipes: filtered);
    return state.recipes;
  }

  Future<void> _fetchRecipesForSelectedOrganization(
    Organization selectedOrganization,
    Ref ref,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      if (selectedOrganization.id == PersonalRecipesDummyOrg.instance.id) {
        final userRecipes = ref.read(userRecipesProvider).data;
        state = state.copyWith(recipes: userRecipes, isLoading: false);
      } else {
        // Fetch organization recipes if an organization is selected
        final orgRecipes = await _organizationRecipeService
            .fetchOrganizationRecipes(selectedOrganization.id);
        state = state.copyWith(recipes: orgRecipes, isLoading: false);
      }
    } catch (error) {
      state = state.copyWith(error: error.toString(), isLoading: false);
    }
  }
}

final recipeListProvider =
    StateNotifierProvider<RecipeListNotifier, RecipeListState>((ref) {
  final orgRecipeService = ref.watch(organizationRecipesServiceProvider);
  return RecipeListNotifier(orgRecipeService, ref);
});
