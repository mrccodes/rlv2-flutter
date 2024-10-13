import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_favorite_recipe_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserFavoriteRecipeRepository {
  UserFavoriteRecipeRepository({
    required this.apiService,
  });

  final ApiService apiService;

  Future<UserFavoriteRecipe> createFavoriteRecipe({
    required String userId,
    required UserFavoriteRecipe recipe,
  }) async {
    const endpoint = '/users/recipes/favorites/';

    try {
      final response = await apiService.postRequest<UserFavoriteRecipe>(
        endpoint,
        recipe.toJson(),
        (val) => UserFavoriteRecipe.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to add favorite recipe');
      rethrow;
    }
  }

  Future<List<UserFavoriteRecipe>> getUserFavoriteRecipesByUserId({
    required String userId,
  }) async {
    final endpoint = '/users/$userId/recipes/favorites/';

    try {
      final response = await apiService.getRequest<List<UserFavoriteRecipe>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => UserFavoriteRecipe.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch favorite recipes');
      rethrow;
    }
  }

  Future<UserFavoriteRecipe> updateUserFavoriteRecipe({
    required String userId,
    required String userFavoriteRecipeId,
    required UserFavoriteRecipe userFavoriteRecipe,
  }) async {
    final endpoint = '/users/$userId/recipes/favorites/$userFavoriteRecipeId';

    try {
      final response = await apiService.putRequest<UserFavoriteRecipe>(
        endpoint,
        userFavoriteRecipe.toJson(),
        (val) => UserFavoriteRecipe.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update favorite recipe');
      rethrow;
    }
  }

  Future<UserFavoriteRecipe> deleteUserFavoriteRecipe({
    required String userId,
    required String userFavoriteRecipeId,
  }) async {
    final endpoint = '/users/$userId/recipes/favorites/$userFavoriteRecipeId';

    try {
      final response = await apiService.deleteRequest<UserFavoriteRecipe>(
        endpoint,
        (val) => UserFavoriteRecipe.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete favorite recipe');
      rethrow;
    }
  }

  Future<List<UserFavoriteRecipe>> deleteAllUserFavoriteRecipes({
    required String userId,
  }) async {
    final endpoint = '/users/$userId/recipes/favorites/';

    try {
      final response = await apiService.deleteRequest<List<UserFavoriteRecipe>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => UserFavoriteRecipe.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete all favorite recipes');
      rethrow;
    }
  }

  Future<UserFavoriteRecipe> getUserFavoriteRecipeById({
    required String userId,
    required String userFavoriteRecipeId,
  }) async {
    final endpoint = '/users/$userId/recipes/favorites/$userFavoriteRecipeId';

    try {
      final response = await apiService.getRequest<UserFavoriteRecipe>(
        endpoint,
        (val) => UserFavoriteRecipe.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch favorite recipe');
      rethrow;
    }
  }
}
