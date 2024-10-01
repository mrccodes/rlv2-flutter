// lib/widgets/custom_circular_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCircularButton extends ConsumerWidget {
  const CustomCircularButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
    this.isSelected = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.secondary;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: Ink(
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
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          // Optional: Customize splash color
          splashColor: color.withOpacity(0.2),
          child: SizedBox(
            width: 110,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                // Ensure the column sizes to its content
                mainAxisSize: MainAxisSize.min,
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
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
