import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_favorite_recipe_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_favorite_recipe.service.dart';

class UserFavoriteRecipesState {
  UserFavoriteRecipesState({
    this.favoriteRecipes = const [],
    this.isLoading = false,
    this.error,
  });

  final List<UserFavoriteRecipe> favoriteRecipes;
  final bool isLoading;
  final String? error;

  UserFavoriteRecipesState Function() initial = UserFavoriteRecipesState.new;

  @override
  String toString() {
    return 'UserFavoriteRecipesState('
        'favoriteRecipes: $favoriteRecipes, '
        'isLoading: $isLoading, '
        'error: $error)';
  }

  UserFavoriteRecipesState copyWith({
    List<UserFavoriteRecipe>? favoriteRecipes,
    bool? isLoading,
    String? error,
  }) {
    return UserFavoriteRecipesState(
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userFavoriteRecipeProvider =
    StateNotifierProvider<UserFavoriteRecipeNotifier, UserFavoriteRecipesState>(
  (ref) {
    final userFavoriteRecipeService =
        ref.watch(userFavoriteRecipeServiceProvider);
    return UserFavoriteRecipeNotifier(
      userFavoriteRecipeService: userFavoriteRecipeService,
    );
  },
);

class UserFavoriteRecipeNotifier
    extends StateNotifier<UserFavoriteRecipesState> {
  UserFavoriteRecipeNotifier({
    required this.userFavoriteRecipeService,
  }) : super(UserFavoriteRecipesState());

  final UserFavoriteRecipeService userFavoriteRecipeService;

  Future<void> loadUserFavoriteRecipes(String userId) async {
    state = state.copyWith(
      isLoading: true,
    );
    try {
      final favoriteRecipes =
          await userFavoriteRecipeService.getUserFavoriteRecipesByUserId(
        userId: userId,
      );
      state = state.copyWith(favoriteRecipes: favoriteRecipes);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
