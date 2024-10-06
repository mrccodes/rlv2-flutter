import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class RecipeRepository {
  RecipeRepository({required this.apiService});

  final ApiService apiService;

  Future<List<Recipe>> fetchRecipes() async {
    const endpoint = '/recipes';

    try {
      final response = await apiService.getRequest<List<Recipe>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => Recipe.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch recipes');
      rethrow;
    }
  }

  Future<Recipe> fetchRecipeById(String recipeId) async {
    final endpoint = '/recipes/$recipeId';

    try {
      final response = await apiService.getRequest<Recipe>(
        endpoint,
        Recipe.fromJson,
      );

      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch recipe');
      rethrow;
    }
  }

  Future<Recipe> createRecipe(Recipe recipe) async {
    const endpoint = '/recipes';

    try {
      final response = await apiService.postRequest<Recipe>(
        endpoint,
        recipe.toJson(),
        Recipe.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to create recipe');
      rethrow;
    }
  }

  Future<Recipe> updateRecipe(String recipeId, Recipe recipe) async {
    final endpoint = '/recipes/$recipeId';

    try {
      final response = await apiService.putRequest<Recipe>(
        endpoint,
        recipe.toJson(),
        Recipe.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update recipe');
      rethrow;
    }
  }

  Future<Recipe> deleteRecipe(String recipeId) async {
    final endpoint = '/recipes/$recipeId';

    try {
      return await apiService.deleteRequest<Recipe>(
        endpoint,
        Recipe.fromJson,
      );
    } catch (e) {
      handleError(e, 'Failed to delete recipe');
      rethrow;
    }
  }

  Future<Recipe> patchRecipe(String recipeId, Recipe data) async {
    final endpoint = '/recipes/$recipeId';

    try {
      final response = await apiService.patchRequest<Recipe>(
        endpoint,
        data.toJson(),
        Recipe.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to patch recipe');
      rethrow;
    }
  }
}
