import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.text,
    this.fullWidth = false,
    this.visualDensity = VisualDensity.standard,
    this.icon,
    this.isLoading = false,
    super.key,
    this.buttonType = ButtonType.primary,
  });
  final VisualDensity? visualDensity;
  final VoidCallback? onPressed;
  final String text;
  final bool fullWidth;
  final Widget? icon;
  final bool isLoading;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    // Define styles for primary and secondary buttons
    final primaryStyle = ElevatedButton.styleFrom(
      elevation: 3,
      visualDensity: visualDensity,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.primary,
    );

    final secondaryStyle = ElevatedButton.styleFrom(
      elevation: 3,
      visualDensity: visualDensity,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).primaryColor,
      side: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    );

    // Choose the style based on buttonType
    final buttonStyle =
        buttonType == ButtonType.secondary ? secondaryStyle : primaryStyle;

    if (isLoading) {
      return SizedBox(
        width: fullWidth ? double.infinity : null,
        child: ElevatedButton(
          onPressed: null,
          style: buttonStyle,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              label: Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              icon: icon,
              style: buttonStyle,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
    );
  }
}
