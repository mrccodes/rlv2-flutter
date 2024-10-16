import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';

class NutritionData {
  NutritionData({
    this.calories,
    this.carbohydrates,
    this.fat,
    this.saturatedFat,
    this.cholesterol,
    this.sodium,
    this.fiber,
    this.protein,
  });
  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      calories: json['calories'] as int,
      carbohydrates: json['carbohydrates'] as int,
      fat: json['fat'] as int,
      saturatedFat: json['saturatedFat'] as int,
      protein: json['protein'] as int,
      cholesterol: json['cholesterol'] as int,
      sodium: json['sodium'] as int,
      fiber: json['fiber'] as int,
    );
  }

  NutritionData.fromVersion(RecipeVersionWithData version)
      : calories = version.calories,
        fat = version.fat,
        protein = version.protein,
        carbohydrates = version.carbohydrates,
        fiber = version.fiber,
        sodium = version.sodium,
        saturatedFat = version.saturatedFat,
        cholesterol = version.cholesterol;

  final int? calories;
  final int? carbohydrates;
  final int? fat;
  final int? saturatedFat;
  final int? protein;
  final int? cholesterol;
  final int? sodium;
  final int? fiber;

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'saturatedFat': saturatedFat,
      'protein': protein,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'fiber': fiber,
    };
  }
}
