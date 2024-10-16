import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/step_model.dart' as recipe_model;

class StepList extends StatefulWidget {
  const StepList({
    required this.steps,
    super.key,
  });

  final List<recipe_model.Step> steps;

  @override
  StepListState createState() => StepListState();
}

class StepListState extends State<StepList> {
  // Local list to track completed steps
  List<int> completedSteps = [];

  @override
  Widget build(BuildContext context) {
    // Sort steps by stepNumber
    widget.steps.sort((a, b) => a.stepNumber.compareTo(b.stepNumber));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.steps.map(_buildStepItem).toList(),
    );
  }

  Widget _buildStepItem(recipe_model.Step step) {
    final isCompleted = completedSteps.contains(step.stepNumber);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isCompleted) {
            completedSteps.remove(step.stepNumber); 
          } else {
            completedSteps.add(step.stepNumber); 
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8), 
          ),
          child: ListTile(
            leading: Padding( 
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
              padding: const EdgeInsets.all(2), 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? 
                    Theme.of(context).primaryColor : 
                    Colors.transparent, 
                ),
              ),
              child: CircleAvatar(
                backgroundColor: isCompleted
                    ? Theme.of(context).primaryColor.withOpacity(.2)
                    : Theme.of(context).colorScheme.tertiary, 
                radius: 24,
                child: isCompleted
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor) 
                    : Text(
                        step.stepNumber.toString(), 
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
              ),
            ),
          ),
            title: Text(
              step.instruction,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
