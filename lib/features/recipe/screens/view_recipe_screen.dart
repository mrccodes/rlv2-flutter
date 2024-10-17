import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/features/recipe/models/nutrition_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';
import 'package:rlv2_flutter/features/recipe/screens/create_recipe_screen.dart';
import 'package:rlv2_flutter/features/recipe/utils/find_recipe_owner.dart';
import 'package:rlv2_flutter/features/recipe/widgets/allergen_list.dart';
import 'package:rlv2_flutter/features/recipe/widgets/category_chip_widget.dart';
import 'package:rlv2_flutter/features/recipe/widgets/difficulty_badge.dart';
import 'package:rlv2_flutter/features/recipe/widgets/ingredient_list.dart';
import 'package:rlv2_flutter/features/recipe/widgets/nutrition_facts.dart';
import 'package:rlv2_flutter/features/recipe/widgets/recipe_metadata.dart';
import 'package:rlv2_flutter/features/recipe/widgets/step_list.dart';
import 'package:rlv2_flutter/features/recipe/widgets/tip_list.dart';
import 'package:rlv2_flutter/utils/constants.dart';
import 'package:rlv2_flutter/utils/format_time_string.dart';

class ViewRecipeScreen extends ConsumerStatefulWidget {
  const ViewRecipeScreen({
    required this.recipe,
    required this.version,
    super.key,
  });
  final RecipeWithData recipe;
  final RecipeVersionWithData? version;

  @override
  ViewRecipeScreenState createState() => ViewRecipeScreenState();
}

class ViewRecipeScreenState extends ConsumerState<ViewRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    // You now have access to `ref` inside the `build` method.

    Widget renderChild(Widget child) {
      if (widget.recipe.versions.isEmpty) {
        return Stack(
          children: [
            child,
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Add a new version
                },
              ),
            ),
          ],
        );
      } else if (widget.version == null) {
        return const Text('Version not found');
      } else {
        return child;
      }
    }

    final versionNumber = widget.version!.versionNumber;
    final isLatestVersion =
        widget.recipe.versions.last.versionNumber == versionNumber;

    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.name)),
      body: Stack(
        children: [
          renderChild(
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 72,
              ),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'v$versionNumber'
                        ' ${isLatestVersion ? '(Latest)' : ''}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const Spacer(),
                      DifficultyBadge(
                        difficulty: RecipeDifficulty.fromString(
                          widget.version!.difficulty,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    findRecipeOwner(widget.recipe, ref),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Created ${formatTimeAgoString(
                      widget.recipe.versions.last.createdAt,
                    )}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  CategoryChipWidget(categories: widget.version!.categories),
                  const SizedBox(height: 16),
                  AllergenIndicator(allergens: widget.version!.allergens),
                  NutritionFactsAccordion(
                    nutritionData: NutritionData.fromVersion(widget.version!),
                  ),
                  const SizedBox(height: 8),
                  RecipeMetadata(
                    cookTime: widget.version!.cookTime,
                    prepTime: widget.version!.prepTime,
                    servings: widget.version!.servings,
                  ),
                  const SizedBox(height: 8),
                  IngredientAccordion(
                    simpleIngredients: widget.version!.simpleIngredients,
                    complexIngredients: widget.version!.complexIngredients,
                  ),
                  const SizedBox(height: 8),
                  Text('Steps', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  StepList(
                    steps: StepItem.fromRecipeVersionSteps(
                      widget.version!.steps,
                    ),
                    editable: false,
                  ),
                  const SizedBox(height: 8),
                  TipList(tips: widget.version!.tips),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.tertiary, // Background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, -2), // Shadow position
                  ),
                ],
              ),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<CreateRecipeScreen>(
                      builder: (context) => CreateRecipeScreen(
                        recipe: widget.recipe,
                        previousVersion: widget.version,
                      ),
                    ),
                  );
                },
                text: 'New Version',
                icon: const Icon(Icons.add),
                fullWidth: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
