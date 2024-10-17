import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredient_model.dart';
import 'package:rlv2_flutter/features/recipe/models/simple_ingredient_model.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';

class RecipeVersionSimpleIngredientsWithData
    extends RecipeVersionSimpleIngredient {
  RecipeVersionSimpleIngredientsWithData({
    required this.simpleIngredient,
    required this.unit,
    required super.id,
    required super.simpleIngredientId,
    required super.recipeVersionId,
    required super.qty,
    required super.unitId,
    required super.createdAt,
    required super.updatedAt,
  });
  factory RecipeVersionSimpleIngredientsWithData.fromJson(
    Map<String, dynamic> json,
  ) {
    return RecipeVersionSimpleIngredientsWithData(
      simpleIngredient: SimpleIngredient.fromJson(
        json['simpleIngredient'] as Map<String, dynamic>,
      ),
      id: json['id'] as String,
      simpleIngredientId: json['simpleIngredientId'] as String,
      recipeVersionId: json['recipeVersionId'] as String,
      qty: json['qty'] as num,
      unitId: json['unitId'] as String,
      unit: Unit.fromJson(
        json['unit'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  final SimpleIngredient simpleIngredient;
  final Unit unit;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'simpleIngredientId': simpleIngredientId,
      'recipeVersionId': recipeVersionId,
      'qty': qty,
      'unit': unit.toJson(),
      'unitId': unitId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
