import 'package:rlv2_flutter/features/recipe/models/recipe_version_complex_ingredient_model.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';

class RecipeVersionComplexIngredientWithData
    extends RecipeVersionComplexIngredient {
  RecipeVersionComplexIngredientWithData({
    required this.unit,
    required super.id,
    required super.parentRecipeVersionId,
    required super.childRecipeVersionNumber,
    required super.childRecipeName,
    required super.childRecipeVersionId,
    required super.qty,
    required super.unitId,
    required super.createdAt,
    required super.updatedAt,
    required super.childRecipeId,
  });

  factory RecipeVersionComplexIngredientWithData.fromJson(
    Map<String, dynamic> json,
  ) {
    return RecipeVersionComplexIngredientWithData(
      unit: Unit.fromJson(
        json['unit'] as Map<String, dynamic>,
      ),
      id: json['id'] as String,
      parentRecipeVersionId: json['parentRecipeVersionId'] as String,
      childRecipeVersionNumber: json['childRecipeVersionNumber'] as int,
      childRecipeName: json['childRecipeName'] as String,
      childRecipeId: json['childRecipeId'] as String,
      childRecipeVersionId: json['childRecipeVersionId'] as String,
      qty: json['qty'] as int,
      unitId: json['unitId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  final Unit unit;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentRecipeVersionId': parentRecipeVersionId,
      'childRecipeVersionNumber': childRecipeVersionNumber,
      'childRecipeName': childRecipeName,
      'childRecipeVersionId': childRecipeVersionId,
      'childRecipeId': childRecipeId,
      'qty': qty,
      'unit': unit.toJson(),
      'unitId': unitId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
