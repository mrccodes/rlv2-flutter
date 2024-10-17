import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/widgets/custom_button.dart';
import 'package:rlv2_flutter/core/widgets/text_form_field_widget.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';
import 'package:rlv2_flutter/features/recipe/widgets/step_list.dart';

class EditStepsWidget extends StatefulWidget {
  const EditStepsWidget({
    required this.steps,
    required this.onStepsUpdated,
    super.key,
  });

  final List<StepItem> steps;
  final ValueChanged<List<StepItem>> onStepsUpdated;

  @override
  EditStepsWidgetState createState() => EditStepsWidgetState();
}

class EditStepsWidgetState extends State<EditStepsWidget> {
  late TextEditingController _stepController;
  final _stepFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _stepController = TextEditingController();
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  void _addNewStep(String instruction) {
    // Validate the step form, not the whole form
    if (_stepFormKey.currentState!.validate()) {
      final newStep = StepItem(
        instruction: instruction.trim(),
        stepNumber: widget.steps.length + 1,
        isNew: true,
      );

      setState(() {
        widget.steps.add(newStep);
      });

      widget.onStepsUpdated(widget.steps);
      _stepController.clear();
    }
  }

  void _onStepsUpdated(List<StepItem> updatedSteps) {
    setState(() {
      widget.onStepsUpdated(updatedSteps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.steps.isNotEmpty)
          Text(
            'Drag and drop to reorder or swipe to delete',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        if (widget.steps.isNotEmpty)
          StepList(
            steps: widget.steps,
            onStepsUpdated: _onStepsUpdated,
            editable: true,
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Step ${widget.steps.length + 1}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Form(
          key: _stepFormKey,
          child: TextFormFieldWidget(
            controller: _stepController,
            maxLines: null,
            decoration: InputDecoration(
              hintText:
                  'Enter instruction to add step ${widget.steps.length + 1}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => value != null && value.trim().isEmpty
                ? 'Please enter a step'
                : null,
          ),
        ),
        const SizedBox(height: 8),
        CustomButton(
          onPressed: () => _addNewStep(_stepController.text),
          text: 'Add Step',
          buttonType: ButtonType.secondary,
          icon: const Icon(Icons.add),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
