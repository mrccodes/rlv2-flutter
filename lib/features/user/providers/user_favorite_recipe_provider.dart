import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_favorite_recipe_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_favorite_recipe.service.dart';

class UserFavoriteRecipesState {
  UserFavoriteRecipesState({
    this.data = const [],
    this.isLoading = false,
    this.error,
  });

  final List<UserFavoriteRecipe> data;
  final bool isLoading;
  final String? error;

  UserFavoriteRecipesState Function() initial = UserFavoriteRecipesState.new;

  @override
  String toString() {
    return 'UserFavoriteRecipesState('
        'favoriteRecipes: $data, '
        'isLoading: $isLoading, '
        'error: $error)';
  }

  UserFavoriteRecipesState copyWith({
    List<UserFavoriteRecipe>? data,
    bool? isLoading,
    String? error,
  }) {
    return UserFavoriteRecipesState(
      data: data ?? this.data,
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

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void updateUserFavoriteRecipesLocal(
    List<UserFavoriteRecipe> favoriteRecipes,
  ) {
    state = state.copyWith(data: favoriteRecipes);
  }

  void addUserFavoriteRecipeLocal(UserFavoriteRecipe favoriteRecipe) {
    final favoriteRecipes = List<UserFavoriteRecipe>.from(state.data)
      ..add(favoriteRecipe);
    state = state.copyWith(data: favoriteRecipes);
  }

  void removeUserFavoriteRecipeLocal(UserFavoriteRecipe favoriteRecipe) {
    final favoriteRecipes = List<UserFavoriteRecipe>.from(state.data)
      ..remove(favoriteRecipe);
    state = state.copyWith(data: favoriteRecipes);
  }

  void clearUserFavoriteRecipes() {
    state = UserFavoriteRecipesState();
  }

  Future<void> loadUserFavoriteRecipes(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final favoriteRecipes =
          await userFavoriteRecipeService.getUserFavoriteRecipesByUserId(
        userId: userId,
      );
      state = state.copyWith(data: favoriteRecipes);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
