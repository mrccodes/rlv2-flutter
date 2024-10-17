import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/dropdown_button_form_field_widget.dart';
import 'package:rlv2_flutter/core/widgets/text_field_widget.dart';
import 'package:rlv2_flutter/core/widgets/text_form_field_widget.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_nav_drawer.dart';
import 'package:rlv2_flutter/features/recipe/models/create_simple_ingredient_item_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredients_with_ingredient.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';
import 'package:rlv2_flutter/features/recipe/utils/find_latest_version.dart';
import 'package:rlv2_flutter/features/recipe/widgets/edit_ingredients_widget.dart';
import 'package:rlv2_flutter/features/recipe/widgets/edit_steps_widget.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';
import 'package:rlv2_flutter/utils/constants.dart';

class CreateRecipeScreen extends ConsumerStatefulWidget {
  const CreateRecipeScreen({
    this.recipe,
    this.previousVersion,
    super.key,
  });

  final RecipeWithData? recipe;
  final RecipeVersionWithData? previousVersion;

  @override
  CreateRecipeScreenState createState() => CreateRecipeScreenState();
}

class CreateRecipeScreenState extends ConsumerState<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> tipControllers = [TextEditingController()];
  TextEditingController nameController = TextEditingController();
  TextEditingController servingsController = TextEditingController();
  RecipeDifficulty? selectedDifficulty;
  TextEditingController descriptionController = TextEditingController();

  TextEditingController cookTimeController = TextEditingController();
  TextEditingController prepTimeController = TextEditingController();

  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController carbohydratesController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController saturatedFatController = TextEditingController();
  TextEditingController cholesterolController = TextEditingController();
  TextEditingController fiberController = TextEditingController();
  TextEditingController sodiumController = TextEditingController();

  List<StepItem> stepItems = [];
  List<RecipeVersionSimpleIngredientsWithData> ingredientsToUpdate = [];
  List<RecipeVersionSimpleIngredientsWithData> ingredientsToDelete = [];
  List<CreateSimpleIngredientItem> newIngredients = [];

  bool isPrefilled = true;

  @override
  void initState() {
    super.initState();
    prefillAllFields();
  }

  void prefillAllFields() {
    if (widget.recipe != null) {
      nameController.text = widget.recipe!.name;

      if (widget.previousVersion != null) {
        servingsController.text = widget.previousVersion!.servings.toString();
        selectedDifficulty = RecipeDifficulty.fromString(
          widget.previousVersion!.difficulty,
        );
        descriptionController.text = widget.previousVersion!.description ?? '';

        stepItems =
            StepItem.fromRecipeVersionSteps(widget.previousVersion!.steps);

        // Handle nutritional info as well
        caloriesController.text =
            widget.previousVersion!.calories?.toString() ?? '';
        proteinController.text =
            widget.previousVersion!.protein?.toString() ?? '';
      }
    }
  }

  void clearAllFields() {
    nameController.clear();
    servingsController.clear();
    selectedDifficulty = null;
    descriptionController.clear();
    cookTimeController.clear();
    prepTimeController.clear();
    caloriesController.clear();
    proteinController.clear();
    carbohydratesController.clear();
    fatController.clear();
    saturatedFatController.clear();
    cholesterolController.clear();
    fiberController.clear();
    sodiumController.clear();
    stepItems = [];
    tipControllers = [TextEditingController()];
  }

  @override
  Widget build(BuildContext context) {
    void onStepsUpdated(List<StepItem> updatedSteps) {
      for (final step in updatedSteps) {
        AppLogger.info(step.toString());
      }
    }

    Widget renderPrefillSwitch() {
      if (widget.recipe == null) {
        return const SizedBox.shrink();
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Prefill with latest version data?'),
          Switch(
            value: isPrefilled,
            onChanged: (value) {
              setState(() {
                isPrefilled = value;
                if (isPrefilled) {
                  prefillAllFields();
                } else {
                  clearAllFields();
                }
              });
            },
          ),
        ],
      );
    }

    void onExistingIngredientDeleted(
      RecipeVersionSimpleIngredientsWithData ingredient,
    ) {
      setState(() {
        ingredientsToDelete.add(ingredient);
      });
    }

    void onNewIngredientsUpdated(
      List<CreateSimpleIngredientItem> updatedIngredients,
    ) {
      setState(() {
        newIngredients = updatedIngredients;
      });
    }

    final latestVersion = findLatestVersion(widget.recipe?.versions ?? []);

    final nextVersionNumber = latestVersion?.versionNumber != null
        ? latestVersion!.versionNumber + 1
        : 1;
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(
          widget.recipe == null
              ? 'Create New Recipe'
              : 'Create Version $nextVersionNumber',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Recipe Name (Editable or not based on context)
            renderPrefillSwitch(),

            if (widget.recipe == null)
              TextFormFieldWidget(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Recipe Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipe name';
                  }
                  return null;
                },
              )
            else
              Text(
                widget.recipe!.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

            Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    // Servings
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: TextFormFieldWidget(
                        controller: servingsController,
                        decoration:
                            const InputDecoration(labelText: 'Servings'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // Difficulty
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: DropdownButtonFormFieldWidget<RecipeDifficulty>(
                        value: selectedDifficulty,
                        items: RecipeDifficulty.values
                            .map(
                              (difficulty) =>
                                  DropdownMenuItem<RecipeDifficulty>(
                                value: difficulty,
                                child: Text(difficulty.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDifficulty = value;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Difficulty'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    // Cook Time
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: TextFormFieldWidget(
                        controller: cookTimeController,
                        decoration: const InputDecoration(
                          labelText: 'Cook Time',
                          suffixText: 'minutes',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // Prep Time
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: TextFormFieldWidget(
                        controller: prepTimeController,
                        decoration: const InputDecoration(
                          labelText: 'Prep Time',
                          suffixText: 'minutes',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Recipe Description',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textAlignVertical: TextAlignVertical.top,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            EditIngredientWidget(
              existingIngredients:
                  widget.previousVersion?.simpleIngredients ?? [],
              onExistingIngredientDeleted: onExistingIngredientDeleted,
              onNewIngredientsUpdated: onNewIngredientsUpdated,
            ),

            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            EditStepsWidget(
              steps: StepItem.fromRecipeVersionSteps(
                widget.previousVersion?.steps ?? [],
              ),
              onStepsUpdated: onStepsUpdated,
            ),
            // Nutritional Info

            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(
                'Nutrition information per serving',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              shape: const Border(),
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextFieldWidget(
                            controller: caloriesController,
                            decoration: const InputDecoration(
                              labelText: 'Calories',
                              suffixText: 'kcal',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TextFieldWidget(
                            controller: proteinController,
                            decoration: const InputDecoration(
                              labelText: 'Protein',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextFieldWidget(
                            controller: carbohydratesController,
                            decoration: const InputDecoration(
                              labelText: 'Carbohydrates',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TextFieldWidget(
                            controller: fatController,
                            decoration: const InputDecoration(
                              labelText: 'Fat',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextFieldWidget(
                            controller: saturatedFatController,
                            decoration: const InputDecoration(
                              labelText: 'Saturated Fat',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TextFieldWidget(
                            controller: cholesterolController,
                            decoration: const InputDecoration(
                              labelText: 'Cholesterol',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextFieldWidget(
                            controller: fiberController,
                            decoration: const InputDecoration(
                              labelText: 'Fiber',
                              suffixText: 'g',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TextFieldWidget(
                            controller: sodiumController,
                            decoration: const InputDecoration(
                              labelText: 'Sodium',
                              suffixText: 'mg',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Submit the form data
                }
              },
              child: const Text('Submit Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
