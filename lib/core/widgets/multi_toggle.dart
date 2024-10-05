import 'package:flutter/material.dart';
import 'package:rlv2_flutter/utils/capitalize_string.dart';

class ToggleOption<T> {
  ToggleOption({required this.label, this.color});
  final T label;  // Enum or other type
  final Color? color;
}

class MultiToggle<T> extends StatefulWidget {
  const MultiToggle({
    required this.options,
    required this.initialOption,
    required this.onToggle,
    this.label,
    super.key,
  });

  final List<ToggleOption<T>> options;  
  final ToggleOption<T> initialOption;  
  final String? label;
  final void Function(T) onToggle;  

  @override
  MultiToggleState<T> createState() => MultiToggleState<T>();
}

class MultiToggleState<T> extends State<MultiToggle<T>> {
  late T selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialOption.label;  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.label!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.options.map(
            _buildToggleOption,
            ).toList(),
        ),
      ],
    );
  }

  Widget _buildToggleOption(ToggleOption<T> option) {
    final defaultColor = Theme.of(context).primaryColor;
    final isSelected = selectedOption == option.label;

    return GestureDetector(
      onTap: () => _onPressed(option.label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? 
            defaultColor : 
            Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          capitalize(
            option.label.toString().split('.').last, 
          ),
          style: TextStyle(
            color: isSelected ? 
              Theme.of(context).colorScheme.primary : 
              defaultColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onPressed(T option) {
    setState(() {
      selectedOption = option;  // Update selected option
    });
    widget.onToggle(option);  // Notify parent widget of the change
  }
}
