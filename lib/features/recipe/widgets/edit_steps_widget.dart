import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/recipe/models/step_item_model.dart';
import 'package:rlv2_flutter/features/recipe/widgets/step_list.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

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
          StepList(
            steps: widget.steps,
            onStepsUpdated: _onStepsUpdated,
            editable: true,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Step ${widget.steps.length + 1}', 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: _stepFormKey,
          child: TextFormField(
          controller: _stepController,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Enter instruction for Step ${widget.steps.length + 1}', 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) => value != null && value.trim().isEmpty
              ? 'Please enter a step'
              : null,
        ),
        ),
                
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => _addNewStep(_stepController.text),
          child: const Text('Add Step'),
        ),
      ],
    );
  }
}
