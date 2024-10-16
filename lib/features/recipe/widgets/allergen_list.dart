import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/allergen_model.dart';

class AllergenIndicator extends StatelessWidget {
  AllergenIndicator({required this.allergens, super.key});
  final List<Allergen> allergens;

  final Map<String, IconData> allergenIcons = {
    'milk': Icons.local_drink_outlined,
    'eggs': Icons.egg_outlined,
    'fish': Icons.set_meal_outlined,
    'shellfish': Icons.restaurant_menu_outlined,
    'tree_nuts': Icons.eco_outlined,
    'peanuts': Icons.grain_outlined,
    'wheat': Icons.grain_outlined,
    'soybeans': Icons.spa_outlined,
    'sesame': Icons.grain_outlined,
    'mustard': Icons.fastfood_outlined,
    'corn': Icons.eco_outlined,
    'gluten': Icons.bakery_dining_outlined,
  };

  @override
  Widget build(BuildContext context) {
    if (allergens.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Allergens', style: Theme.of(context).textTheme.labelMedium),
        Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: allergens.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final allergen = allergens[index];
              final icon = allergenIcons[allergen.value] ?? Icons.error_outline;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    allergen.label,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
