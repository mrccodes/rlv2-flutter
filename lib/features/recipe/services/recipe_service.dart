import 'package:rlv2_flutter/features/recipe/models/recipe_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/repositories/recipe_repository.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class RecipeService {
  RecipeService({
    required this.recipeRepository,
  });

  final RecipeRepository recipeRepository;

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await recipeRepository.fetchRecipes();
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch recipes');
      rethrow;
    }
  }

  Future<Recipe> fetchRecipeById(String recipeId) async {
    try {
      final response = await recipeRepository.fetchRecipeById(recipeId);
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch recipe');
      rethrow;
    }
  }

  Future<Recipe> createRecipe(Recipe recipe) async {
    try {
      final response = await recipeRepository.createRecipe(recipe);
      return response;
    } catch (e) {
      handleError(e, 'Failed to create recipe');
      rethrow;
    }
  }

  Future<Recipe> updateRecipe(String recipeId, Recipe recipe) async {
    try {
      final response = await recipeRepository.updateRecipe(recipeId, recipe);
      return response;
    } catch (e) {
      handleError(e, 'Failed to update recipe');
      rethrow;
    }
  }

  Future<Recipe> deleteRecipe(String recipeId) async {
    try {
      final response = await recipeRepository.deleteRecipe(recipeId);
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete recipe');
      rethrow;
    }
  }

  Future<Recipe> patchRecipe(String recipeId, Recipe recipe) async {
    try {
      final response = await recipeRepository.patchRecipe(recipeId, recipe);
      return response;
    } catch (e) {
      handleError(e, 'Failed to patch recipe');
      rethrow;
    }
  }

  Future<RecipeWithData> fetchUserRecipeWithData(String recipeId) async {
    try {
      final response = await recipeRepository.fetchUserRecipeWithData(recipeId);
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch recipe with data');
      rethrow;
    }
  }
}
