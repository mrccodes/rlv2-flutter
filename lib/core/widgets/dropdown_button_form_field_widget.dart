import 'package:flutter/material.dart';

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  const DropdownButtonFormFieldWidget({
    super.key,
    this.items,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.value,
    this.isExpanded = false,
    this.hint,
    this.autofocus = false,
    this.focusNode,
    this.elevation,
    this.decoration,
    this.borderRadius,
    this.style,
  });
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final T? value;
  final bool isExpanded;
  final Widget? hint;
  final bool autofocus;
  final FocusNode? focusNode;
  final double? elevation;
  final InputDecoration? decoration;
  final BorderRadius? borderRadius;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (decoration?.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8),
            child: Text(
              decoration!.labelText!,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        else
          const SizedBox(),
        Material(
          elevation: elevation ?? 8,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: DropdownButtonFormField<T>(
            items: items,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            value: value,
            isExpanded: isExpanded,
            hint: hint,
            autofocus: autofocus,
            focusNode: focusNode,
            decoration: decoration,
            style: style ?? Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
