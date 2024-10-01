// lib/widgets/custom_circular_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCircularButton extends ConsumerWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomCircularButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.secondary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110, // Adjust size as needed
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: color,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8), // Adjust padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Add this line

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    height: 1, // Set line height to match font size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
