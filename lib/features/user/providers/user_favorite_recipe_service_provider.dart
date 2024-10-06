import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_repository_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_favorite_recipe.service.dart';

final userFavoriteRecipeServiceProvider =
    Provider<UserFavoriteRecipeService>((ref) {
  final userFavoriteRecipeRepository =
      ref.watch(userFavoriteRecipeRepositoryProvider);
  return UserFavoriteRecipeService(
    userFavoriteRecipeRepository: userFavoriteRecipeRepository,
  );
});
