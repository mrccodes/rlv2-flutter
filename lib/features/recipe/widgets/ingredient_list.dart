import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_complex_ingredient_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredients_with_ingredient.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_provider.dart';
import 'package:rlv2_flutter/features/recipe/screens/view_recipe_screen.dart';
import 'package:rlv2_flutter/features/recipe/utils/check_for_version.dart';

class IngredientAccordion extends ConsumerWidget {
  const IngredientAccordion({
    required this.simpleIngredients,
    required this.complexIngredients,
    super.key,
  });
  final List<RecipeVersionSimpleIngredientsWithData> simpleIngredients;
  final List<RecipeVersionComplexIngredientWithData> complexIngredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ingredientStr(int qty, Unit unit, String name) {
      var s = qty > 1 ? 's' : '';
      s = name == 'inch' && qty > 1 ? 'es' : s;
      return '$qty '
          '${unit.label.toLowerCase()}$s '
          '$name';
    }

    return ExpansionTile(
      title: Text(
        'Ingredients',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.zero, // Removes the padding from the children
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      children: [
        // Simple Ingredients
        ...simpleIngredients.map(
          (ingredient) => ListTile(
            title: Text(
              ingredientStr(
                ingredient.qty,
                ingredient.unit,
                ingredient.simpleIngredient.name,
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        // Complex Ingredients
        ...complexIngredients.map((complexIngredient) {
          final isLoading = ref.watch(recipeProvider).isLoading;
          final isFetching = ref.watch(recipeProvider).isFetching;
          return GestureDetector(
            onTap: () async {
              final recipe = await ref
                  .read(recipeProvider.notifier)
                  .fetchRecipeWithData(complexIngredient.childRecipeId);
              final version = checkForVersion(
                complexIngredient.childRecipeVersionId,
                recipe.versions,
              );

              if (context.mounted && version != null) {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => ViewRecipeScreen(
                      recipe: recipe,
                      version: version,
                    ),
                  ),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  ingredientStr(
                    complexIngredient.qty,
                    complexIngredient.unit,
                    complexIngredient.childRecipeName,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing:
                    isLoading && isFetching == complexIngredient.childRecipeId
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        }),
      ],
    );
  }
}
