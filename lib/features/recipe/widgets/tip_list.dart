import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/tip_model.dart';

// ExpansionTile widget for displaying tips
class TipList extends StatelessWidget {
  const TipList({required this.tips, super.key});
  final List<Tip> tips;

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) {
      return const SizedBox();
    }
    return ExpansionTile(
      title: Text(
        'Tips',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      shape: const Border(),
      children: tips.map((tip) {
        return ListTile(
          title: Text(
            tip.body,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        );
      }).toList(),
    );
  }
}
