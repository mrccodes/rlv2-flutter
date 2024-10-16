import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/nutrition_data_model.dart';
import 'package:rlv2_flutter/features/recipe/utils/format_nullable.dart';

class NutritionFactsAccordion extends StatelessWidget {
  const NutritionFactsAccordion({
    required this.nutritionData,
    super.key,
  });

  final NutritionData nutritionData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Nutrition',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      shape: const Border(),
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      children: [
        _buildNutritionTile('Calories', formatNullable(nutritionData.calories)),
        _buildNutritionTile('Protein', formatNullable(nutritionData.protein)),
        _buildNutritionTile('Fat', formatNullable(nutritionData.fat)),
        _buildNutritionTile(
          'Saturated Fat',
          formatNullable(nutritionData.saturatedFat),
        ),
        _buildNutritionTile(
          'Carbohydrates',
          formatNullable(nutritionData.carbohydrates),
        ),
        _buildNutritionTile('Fiber', formatNullable(nutritionData.fiber)),
        _buildNutritionTile('Sodium', formatNullable(nutritionData.sodium)),
        _buildNutritionTile(
          'Cholesterol',
          formatNullable(nutritionData.cholesterol),
        ),
      ],
    );
  }

  Widget _buildNutritionTile(String label, String value) {
    return ListTile(
      dense: true,
      title: Text(label),
      trailing: Text(value),
    );
  }
}
