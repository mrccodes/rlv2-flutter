import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';
import 'package:rlv2_flutter/features/recipe/utils/find_latest_version.dart';
import 'package:rlv2_flutter/features/recipe/widgets/edit_steps_widget.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

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
  String? selectedDifficulty;
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
        selectedDifficulty = widget.previousVersion!.difficulty;
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

    final latestVersion = findLatestVersion(widget.recipe?.versions ?? []);

    final nextVersionNumber = latestVersion?.versionNumber != null
        ? latestVersion!.versionNumber + 1
        : 1;
    return Scaffold(
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
              TextFormField(
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
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: servingsController,
                        decoration:
                            const InputDecoration(labelText: 'Servings'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // Difficulty
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField<String>(
                        value: selectedDifficulty,
                        items:
                            ['beginner', 'intermediate', 'advanced', 'expert']
                                .map(
                                  (difficulty) => DropdownMenuItem(
                                    value: difficulty,
                                    child: Text(difficulty),
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
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
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
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
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

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              'Drag and drop to reorder or swipe to delete',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            EditStepsWidget(
              steps: StepItem.fromRecipeVersionSteps(
                widget.previousVersion?.steps ?? [],
              ),
              onStepsUpdated: onStepsUpdated,
            ),
            // Nutritional Info

            TextField(
              controller: caloriesController,
              decoration: const InputDecoration(
                labelText: 'Calories',
                suffixText: 'per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: proteinController,
              decoration: const InputDecoration(
                labelText: 'Protein',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: carbohydratesController,
              decoration: const InputDecoration(
                labelText: 'Carbohydrates',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: fatController,
              decoration: const InputDecoration(
                labelText: 'Fat',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: saturatedFatController,
              decoration: const InputDecoration(
                labelText: 'Saturated Fat',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: cholesterolController,
              decoration: const InputDecoration(
                labelText: 'Cholesterol',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: fiberController,
              decoration: const InputDecoration(
                labelText: 'Fiber',
                suffixText: 'grams per serving',
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: sodiumController,
              decoration: const InputDecoration(
                labelText: 'Sodium',
                suffixText: 'mg per serving',
              ),
              keyboardType: TextInputType.number,
            ),

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
