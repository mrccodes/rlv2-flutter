import 'package:rlv2_flutter/features/recipe/models/create_recipe_step_model.dart';

class RecipeVersionStep extends CreateRecipeVersionStep {
  RecipeVersionStep({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required super.versionId,
    required super.stepNumber,
    required super.instruction,
  });

  factory RecipeVersionStep.fromJson(Map<String, dynamic> json) {
    return RecipeVersionStep(
      id: json['id'] as String,
      instruction: json['instruction'] as String,
      versionId: json['versionId'] as String,
      stepNumber: json['stepNumber'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String id;
  final String createdAt;
  final String updatedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instruction': instruction,
      'versionId': versionId,
      'stepNumber': stepNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
