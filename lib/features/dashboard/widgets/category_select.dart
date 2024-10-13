import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/models/category_model.dart';
import 'package:rlv2_flutter/features/recipe/providers/category_provider.dart';
import 'package:rlv2_flutter/utils/capitalize_string.dart';

class CategorySelector extends ConsumerWidget {
  const CategorySelector({required this.categories, super.key});
  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategories = ref.watch(
      categoryProvider.select((state) => state.selectedCategories),
    );

    if (categories.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children:[
        //     const Text('Categories'),
        //       if (selectedCategories.isNotEmpty)
        //         CustomButton(onPressed:
        //         () => ref
        //           .read(categoryProvider.notifier)
        //           .clearSelections(),
        //         text: 'Clear',
        //         buttonType: ButtonType.secondary,
        //         visualDensity: VisualDensity.compact,
        //         )
        //       else
        //         const SizedBox(height: 40),
        //     ],
        //   ),
        // ),

        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategories.contains(category);
                final theme = Theme.of(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => ref
                        .read(categoryProvider.notifier)
                        .toggleCategory(category),
                    child: Chip(
                      label: Text(
                        capitalize(category.name),
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                      backgroundColor: isSelected
                          ? theme.primaryColor
                          : theme.colorScheme.secondary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
