import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/utils/format_minutes.dart';
import 'package:rlv2_flutter/features/recipe/utils/format_nullable.dart';

class RecipeMetadata extends StatelessWidget {
  const RecipeMetadata({
    required this.cookTime,
    required this.prepTime,
    required this.servings,
    super.key,
  });

  final int? cookTime;
  final int? prepTime;
  final int? servings;

  @override
  Widget build(BuildContext context) {
    String format(int? val) {
      return val != null ? formatMinutes(val) : formatNullable(val);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cook Time
        Expanded(
          child: Column(
            children: [
              const Icon(Icons.schedule, size: 16),
              const SizedBox(height: 4),
              Text(
                'Cook Time',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                format(cookTime),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        // Vertical Divider

        const SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
            width: 20,
          ),
        ),

        // Prep Time
        Expanded(
          child: Column(
            children: [
              const Icon(Icons.kitchen, size: 16),
              const SizedBox(height: 4),
              Text(
                'Prep Time',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                format(prepTime),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        // Vertical Divider
        const SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
            width: 20,
          ),
        ),

        // Servings
        Expanded(
          child: Column(
            children: [
              const Icon(Icons.restaurant, size: 16),
              const SizedBox(height: 4),
              Text(
                'Servings',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                formatNullable(servings),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
