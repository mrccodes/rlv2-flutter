import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.buttonType = ButtonType.primary,
  });
  final VoidCallback? onPressed;
  final String text;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    // Define styles for primary and secondary buttons
    final primaryStyle = ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.primary,
    );

    final secondaryStyle = ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).primaryColor,
      side: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    );

    // Choose the style based on buttonType
    final buttonStyle =
        buttonType == ButtonType.secondary ? secondaryStyle : primaryStyle;

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(text),
    );
  }
}
