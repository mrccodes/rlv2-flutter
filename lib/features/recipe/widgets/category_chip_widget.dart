import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/utils/capitalize_string.dart';

class CategoryChipWidget extends StatelessWidget {
  const CategoryChipWidget({
    required this.categories,
    super.key,
  });
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox();
    }
    return Wrap(
      spacing: 8, // Spacing between chips
      runSpacing: 4, // Spacing between rows of chips
      children: categories.map((category) {
        return Chip(
          elevation: 3,
          visualDensity: const VisualDensity(horizontal: -3, vertical: -4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          label: Text(
            capitalize(category.name),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2),
        );
      }).toList(),
    );
  }
}
