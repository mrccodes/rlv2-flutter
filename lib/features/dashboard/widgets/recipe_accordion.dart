import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_list_provider.dart';
import 'package:rlv2_flutter/features/recipe/screens/view_recipe_screen.dart';
import 'package:rlv2_flutter/features/recipe/widgets/difficulty_badge.dart';
import 'package:rlv2_flutter/utils/format_time_string.dart';

class RecipeAccordion extends ConsumerWidget {
  const RecipeAccordion({super.key});

  List<RecipeWithData> sortByName(List<RecipeWithData> rec) {
    return List<RecipeWithData>.from(rec)
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeListProvider).recipes;
    final filteredRecipes = ref.watch(recipeListProvider).filteredRecipes;
    final recipesToRender = filteredRecipes.isNotEmpty
        ? sortByName(filteredRecipes)
        : sortByName(recipes);

    return Expanded(
      child: ListView.builder(
        itemCount: recipesToRender.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final recipe = recipesToRender[index];
          return RecipeAccordionItem(recipe: recipe);
        },
      ),
    );
  }
}

class RecipeAccordionItem extends StatefulWidget {
  const RecipeAccordionItem({required this.recipe, super.key});
  final RecipeWithData recipe;

  @override
  RecipeAccordionItemState createState() => RecipeAccordionItemState();
}

class RecipeAccordionItemState extends State<RecipeAccordionItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.recipe.name),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 16),
              height: 160, // Set a fixed height for the horizontal list
              child: SizedBox.expand(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.recipe.versions.length,
                  itemBuilder: (context, index) {
                    final idx = widget.recipe.versions.length - 1 - index;
                    final version = widget.recipe.versions[idx];
                    return RecipeVersionCard(
                      recipe: widget.recipe,
                      version: version,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RecipeVersionCard extends StatelessWidget {
  const RecipeVersionCard({
    required this.version,
    required this.recipe,
    super.key,
  });
  final RecipeVersionWithData version;
  final RecipeWithData recipe;

  @override
  Widget build(BuildContext context) {
    final ingredientsLength =
        version.simpleIngredients.length + version.complexIngredients.length;

    void onPressed() {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ViewRecipeScreen(
            recipe: recipe,
            version: version,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 225, // Set width for each card
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Version ${version.versionNumber}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                  DifficultyBadge(
                    difficulty: version.difficulty,
                    small: true,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '$ingredientsLength Ingredients',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                '${version.steps.length} Steps',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                'Updated ${formatTimeAgoString(version.updatedAt)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
