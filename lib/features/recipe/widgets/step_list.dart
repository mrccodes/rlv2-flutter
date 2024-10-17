import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';

class StepList extends StatefulWidget {
  const StepList({
    required this.steps,
    required this.editable,
    this.onStepsUpdated,
    super.key,
  });

  final List<StepItem> steps;
  final bool editable;
  final ValueChanged<List<StepItem>>? onStepsUpdated;

  @override
  StepListState createState() => StepListState();
}

class StepListState extends State<StepList> {
  // Local list to track completed steps
  List<int> completedSteps = [];

  @override
  Widget build(BuildContext context) {
    return widget.editable ? _buildEditableList() : _buildReadOnlyList();
  }

  Widget _buildReadOnlyList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.steps.map(_buildStepItem).toList(),
    );
  }

  Widget _buildEditableList() {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: _onReorder,
      children: widget.steps
          .map(
            (step) => Dismissible(
              key: ValueKey(step.recipeVersionStepId ?? step.stepNumber),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _deleteStep(step),
              child: _buildStepItem(step),
            ),
          )
          .toList(),
    );
  }

  void _deleteStep(StepItem step) {
    setState(() {
      widget.steps.remove(step);

      // Update step numbers after deletion
      for (var i = 0; i < widget.steps.length; i++) {
        widget.steps[i] = StepItem(
          instruction: widget.steps[i].instruction,
          stepNumber: i + 1,
          isNew: widget.steps[i].isNew,
          recipeVersionStepId: widget.steps[i].recipeVersionStepId,
        );
      }
    });

    widget.onStepsUpdated?.call(widget.steps); // Notify parent of updated steps
  }

  void _onReorder(int oldIndex, int newIndex) {
    var updatedIndex = newIndex;
    setState(() {
      if (newIndex > oldIndex) {
        updatedIndex -= 1;
      }

      // Move the step
      final movedStep = widget.steps.removeAt(oldIndex);
      widget.steps.insert(updatedIndex, movedStep);

      // Update step numbers after reordering
      for (var i = 0; i < widget.steps.length; i++) {
        widget.steps[i] = StepItem(
          instruction: widget.steps[i].instruction,
          stepNumber: i + 1,
          isNew: widget.steps[i].isNew,
          recipeVersionStepId: widget.steps[i].recipeVersionStepId,
        );
      }
    });

    widget.onStepsUpdated?.call(widget.steps); // Notify parent of updated steps
  }

  Widget _buildStepItem(StepItem step) {
    final isCompleted =
        completedSteps.contains(step.stepNumber) && !widget.editable;

    return ListTile(
      key: ValueKey(step.recipeVersionStepId ?? step.stepNumber),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
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
      enabled: !widget.editable,
      onTap: () {
        setState(() {
          if (isCompleted) {
            completedSteps.remove(step.stepNumber);
          } else {
            completedSteps.add(step.stepNumber);
          }
        });
      },
    );
  }
}
