import 'package:rlv2_flutter/features/recipe/models/step_model.dart';

class StepItem {
  StepItem({
    required this.instruction, 
    required this.stepNumber, 
    required this.isNew, 
    this.recipeVersionStepId,
  });
  final String? recipeVersionStepId; 
  final String instruction;
  final int stepNumber;
  final bool isNew;

  @override
  String toString() {
    return 'StepItem: {recipeVersionStepId: $recipeVersionStepId, '
    'instruction: $instruction, stepNumber: $stepNumber, isNew: $isNew}';
  }


  static List<StepItem> fromRecipeVersionSteps(
    List<RecipeVersionStep> recipeSteps,
    ) {
    return recipeSteps.map((step) {
      return StepItem(
        recipeVersionStepId: step.id,
        instruction: step.instruction,
        stepNumber: step.stepNumber,
        isNew: false,
      );
    }).toList();
  }
}
