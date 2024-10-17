import 'package:flutter/material.dart';
import 'package:rlv2_flutter/utils/capitalize_string.dart';
import 'package:rlv2_flutter/utils/constants.dart';

class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({
    required this.difficulty,
    super.key,
    this.small = false,
    this.colored = true,
  });
  final RecipeDifficulty difficulty;
  final bool small;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    Color badgeColor;

    switch (difficulty) {
      case RecipeDifficulty.beginner:
        badgeColor = const Color.fromARGB(255, 3, 169, 9);
      case RecipeDifficulty.intermediate:
        badgeColor = const Color.fromARGB(255, 230, 209, 19);
      case RecipeDifficulty.advanced:
        badgeColor = Theme.of(context).primaryColor;
      case RecipeDifficulty.expert:
        badgeColor = Theme.of(context).colorScheme.error;
    }

    TextStyle? getTextStyle() {
      return small
          ? Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colored
                    ? badgeColor
                    : Theme.of(context).textTheme.labelSmall?.color,
              )
          : Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colored
                    ? badgeColor
                    : Theme.of(context).textTheme.labelSmall?.color,
              );
    }

    return Card(
      elevation: 3,
      // color: colored ? badgeColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: small
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colored ? badgeColor : Colors.transparent,
          ),
        ),
        child: Text(
          capitalize(difficulty.name),
          style: getTextStyle(),
        ),
      ),
    );
  }
}
