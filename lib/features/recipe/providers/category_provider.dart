import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_list_provider.dart';

class CategoryState {
  CategoryState({
    this.selectedCategories = const [],
    this.isLoading = false,
    this.error,
  });

  CategoryState copyWith({
    List<Category>? selectedCategories,
    List<Category>? userCategories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  final List<Category> selectedCategories;
  final bool isLoading;
  final String? error;
}

// CategoryNotifier that manages the state of selected categories
class CategoryNotifier extends StateNotifier<CategoryState> {

  CategoryNotifier(this.ref) : super(CategoryState());
  final Ref ref;

  // Method to toggle category selection
  void toggleCategory(Category category) {
    if (state.selectedCategories.contains(category)) {
      final newCategoryList = [...state.selectedCategories]..remove(category);
      state = state.copyWith(selectedCategories: newCategoryList);
    } else {
      final newCategoryList = [...state.selectedCategories, category];
      state = state.copyWith(selectedCategories: newCategoryList);
    }
      ref.read(recipeListProvider.notifier).filterByCategories(state.selectedCategories);
  }

  // Method to clear selected categories
  void clearSelections() {
    state = state.copyWith(selectedCategories: []);
  }
}

// Provider to expose the CategoryNotifier
final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
  CategoryNotifier.new,
);
