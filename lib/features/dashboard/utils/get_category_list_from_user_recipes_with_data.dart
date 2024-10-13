import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';

bool categoryIsDuplicate(List<Category> categories, Category category) =>
    categories.any((c) => c.name == category.name);

List<Category> getCategoryListFromUserRecipesWithData(
  List<RecipeWithData> recipes,
) {
  List<RecipeVersionWithData> sortRecipeVersions(
    List<RecipeVersionWithData> versions,
  ) {
    versions.sort(
      (a, b) => a.versionNumber > b.versionNumber ? 1 : -1,
    );
    return versions;
  }

  recipes.map((recipe) => sortRecipeVersions(recipe.versions));

  final latestRecipeVersions =
      recipes.map((recipe) => recipe.versions.last).toList();
  final categories = <Category>[];
  for (final version in latestRecipeVersions) {
    for (final category in version.categories) {
      if (!categoryIsDuplicate(categories, category)) {
        categories.add(category);
      }
    }
  }

  return categories;
}
