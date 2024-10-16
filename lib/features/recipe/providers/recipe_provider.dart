import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_service_provider.dart';
import 'package:rlv2_flutter/features/recipe/services/recipe_service.dart';

class RecipeState {
  RecipeState({
    this.isLoading = false,
    this.isFetching,
    this.error,
  });

  final bool isLoading;
  final String? isFetching;
  final String? error;

  RecipeState copyWith({
    bool? isLoading,
    String? isFetching,
    String? error,
  }) {
    return RecipeState(
      isLoading: isLoading ?? this.isLoading,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'RecipeState('
        'isLoading: $isLoading, '
        'isFetching: $isFetching, '
        'error: $error)';
  }
}

class RecipeWithDataNotifier extends StateNotifier<RecipeState> {
  RecipeWithDataNotifier(this._recipeService) : super(RecipeState());

  final RecipeService _recipeService;

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set isFetching(String? value) {
    state = state.copyWith(isFetching: value);
  }

  String? get isFetching {
    return state.isFetching;
  }

  Future<RecipeWithData> fetchRecipeWithData(
    String recipeId,
    String complexIngredientId,
  ) async {
    try {
      isLoading = true;
      isFetching = complexIngredientId;
      final recipeWithData =
          await _recipeService.fetchUserRecipeWithData(recipeId);
      return recipeWithData;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      isLoading = false;
      isFetching = null;
    }
  }
}

final recipeProvider =
    StateNotifierProvider<RecipeWithDataNotifier, RecipeState>((ref) {
  final recipeService = ref.watch(recipeServiceProvider);
  return RecipeWithDataNotifier(recipeService);
});
