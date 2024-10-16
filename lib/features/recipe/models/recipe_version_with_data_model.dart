import 'package:rlv2_flutter/features/recipe/models/allergen_model.dart';
import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_complex_ingredient_with_data_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_simple_ingredients_with_ingredient.dart';
import 'package:rlv2_flutter/features/recipe/models/step_model.dart';
import 'package:rlv2_flutter/features/recipe/models/tip_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class RecipeVersionWithData extends RecipeVersion {
  RecipeVersionWithData({
    required this.simpleIngredients,
    required this.complexIngredients,
    required this.steps,
    required this.tips,
    required this.categories,
    required this.allergens,

    // Pass required parameters from the parent class RecipeVersion
    required super.id,
    required super.recipeId,
    required super.versionNumber,
    required super.deleted,
    required super.difficulty,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
    super.cookTime,
    super.prepTime,
    super.servings,
    super.rating,
    super.calories,
    super.fat,
    super.saturatedFat,
    super.cholesterol,
    super.sodium,
    super.protein,
    super.carbohydrates,
    super.fiber,

    // Add all other required parameters of RecipeVersion here
  });

  // Adjust fromJson to correctly parse lists from json strings or objects
  factory RecipeVersionWithData.fromJson(Map<String, dynamic> json) {
    AppLogger.info('RecipeVersionWithData.fromJson: ${json['allergens']}');
    return RecipeVersionWithData(
      simpleIngredients: (json['simpleIngredients'] as List)
          .map(
            (item) => RecipeVersionSimpleIngredientsWithData.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      complexIngredients: (json['complexIngredients'] as List)
          .map(
            (item) => RecipeVersionComplexIngredientWithData.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      steps: (json['steps'] as List)
          .map((item) => RecipeVersionStep
          .fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      tips: (json['tips'] as List)
          .map((item) => Tip.fromJson(item as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List)
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList(),
      allergens: (json['allergens'] as List)
          .map((item) => Allergen.fromJson(item as Map<String, dynamic>))
          .toList(),

      // Handle parent class constructor fields
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      versionNumber: json['versionNumber'] as int,
      deleted: json['deleted'] as bool,
      difficulty: json['difficulty'] as String,
      description: json['description'] as String?,
      cookTime: json['cookTime'] as int?,
      prepTime: json['prepTime'] as int?,
      servings: json['servings'] as int?,
      rating: json['rating'] as int?,
      calories: json['calories'] as int?,
      fat: json['fat'] as int?,
      saturatedFat: json['saturatedFat'] as int?,
      cholesterol: json['cholesterol'] as int?,
      sodium: json['sodium'] as int?,
      protein: json['protein'] as int?,
      carbohydrates: json['carbohydrates'] as int?,
      fiber: json['fiber'] as int?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  final List<RecipeVersionSimpleIngredientsWithData> simpleIngredients;
  final List<RecipeVersionComplexIngredientWithData> complexIngredients;
  final List<RecipeVersionStep> steps;
  final List<Tip> tips;
  final List<Category> categories;
  final List<Allergen> allergens;

  // Correct serialization for lists of objects
  @override
  Map<String, dynamic> toJson() {
    return {
      'simpleIngredients': simpleIngredients.map((e) => e.toJson()).toList(),
      'complexIngredients': complexIngredients.map((e) => e.toJson()).toList(),
      'steps': steps.map((e) => e.toJson()).toList(),
      'tips': tips.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
      'allergens': allergens.map((e) => e.toJson()).toList(),
      // Add any additional parent fields here
      ...super.toJson(),
    };
  }
}
