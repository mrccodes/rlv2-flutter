import 'package:rlv2_flutter/features/recipe/models/create_recipe_version_simple_ingredient_model.dart';

class RecipeVersionSimpleIngredient
    extends CreateRecipeVersionSimpleIngredient {
  RecipeVersionSimpleIngredient({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required super.simpleIngredientId,
    required super.recipeVersionId,
    required super.qty,
    required super.unitId,
  });

  factory RecipeVersionSimpleIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeVersionSimpleIngredient(
      id: json['id'] as String,
      simpleIngredientId: json['simpleIngredientId'] as String,
      recipeVersionId: json['recipeVersionId'] as String,
      qty: json['qty'] as num,
      unitId: json['unitId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'simpleIngredientId': simpleIngredientId,
      'recipeVersionId': recipeVersionId,
      'qty': qty,
      'unitId': unitId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
