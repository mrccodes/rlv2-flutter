import 'package:rlv2_flutter/features/user/models/user_favorite_recipe_model.dart';
import 'package:rlv2_flutter/features/user/repositories/user_favorite_recipe_repository.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserFavoriteRecipeService {
  UserFavoriteRecipeService({
    required this.userFavoriteRecipeRepository,
  });

  final UserFavoriteRecipeRepository userFavoriteRecipeRepository;

  Future<UserFavoriteRecipe> createFavoriteRecipe({
    required String userId,
    required UserFavoriteRecipe recipe,
  }) async {
    try {
      final response = await userFavoriteRecipeRepository.createFavoriteRecipe(
        userId: userId,
        recipe: recipe,
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
    try {
      final response =
          await userFavoriteRecipeRepository.getUserFavoriteRecipesByUserId(
        userId: userId,
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
    try {
      final response =
          await userFavoriteRecipeRepository.updateUserFavoriteRecipe(
        userId: userId,
        userFavoriteRecipeId: userFavoriteRecipeId,
        userFavoriteRecipe: userFavoriteRecipe,
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
    try {
      final response =
          await userFavoriteRecipeRepository.deleteUserFavoriteRecipe(
        userId: userId,
        userFavoriteRecipeId: userFavoriteRecipeId,
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
    try {
      final response =
          await userFavoriteRecipeRepository.deleteAllUserFavoriteRecipes(
        userId: userId,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete all favorite recipes');
      rethrow;
    }
  }
}
