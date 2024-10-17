import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_complex_ingredient_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredients_with_ingredient.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_provider.dart';
import 'package:rlv2_flutter/features/recipe/screens/view_recipe_screen.dart';
import 'package:rlv2_flutter/features/recipe/utils/check_for_version.dart';
import 'package:rlv2_flutter/features/recipe/utils/format_ingredient.dart';
import 'package:rlv2_flutter/utils/widget_handle_error.dart';

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
              formatIngredient(
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
              try {
                final recipe =
                    await ref.read(recipeProvider.notifier).fetchRecipeWithData(
                          complexIngredient.childRecipeId,
                          complexIngredient.id,
                        );
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
              } catch (err) {
                if (context.mounted) {
                  widgetHandleError(err, context, notifyUser: true);
                }
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
                  formatIngredient(
                    complexIngredient.qty,
                    complexIngredient.unit,
                    complexIngredient.childRecipeName,
                    complexIngredient.childRecipeVersionNumber,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: isLoading && isFetching == complexIngredient.id
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
