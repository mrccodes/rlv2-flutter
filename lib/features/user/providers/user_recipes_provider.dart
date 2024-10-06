import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';

class UserRecipesState {
  UserRecipesState({
    this.data = const [],
    this.isLoading = false,
    this.error = false,
  });

  final List<RecipeWithData> data;
  final bool isLoading;
  final bool error;

  UserRecipesState copyWith({
    List<RecipeWithData>? data,
    bool? isLoading,
    bool? error,
  }) {
    return UserRecipesState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userRecipesProvider =
    StateNotifierProvider<UserRecipesNotifier, UserRecipesState>((ref) {
  return UserRecipesNotifier();
});

class UserRecipesNotifier extends StateNotifier<UserRecipesState> {
  UserRecipesNotifier() : super(UserRecipesState());

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  bool get isLoading => state.isLoading == true;

  void updateUserRecipesLocal(List<RecipeWithData> recipes) {
    state = state.copyWith(data: recipes);
  }

  void clearUserRecipes() {
    state = UserRecipesState();
  }
}
