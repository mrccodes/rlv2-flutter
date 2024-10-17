import 'package:rlv2_flutter/features/recipe/models/create_simple_ingredient_model.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';

/// Used to create a new full recipe version
class CreateSimpleIngredientItem {
  CreateSimpleIngredientItem({
    required this.ingredient,
    required this.quantity,
    required this.unit,
  });

  final CreateSimpleIngredient ingredient;
  final num quantity;
  final Unit unit;

  CreateSimpleIngredientItem copyWith({
    CreateSimpleIngredient? ingredient,
    num? quantity,
    Unit? unit,
  }) {
    return CreateSimpleIngredientItem(
      ingredient: ingredient ?? this.ingredient,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient.toJson(),
      'quantity': quantity,
      'unit': unit.toJson(),
    };
  }
}
