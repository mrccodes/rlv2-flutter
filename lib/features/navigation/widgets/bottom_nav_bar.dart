// lib/widgets/custom_bottom_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/circular_button.dart';
import 'package:rlv2_flutter/features/navigation/navigation_provider.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return SizedBox(
      height: 100, // Adjust height to fit the circular button
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // BottomAppBar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              height: 65,
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Left Side (e.g., Home)
                    _buildNavItem(
                      context: context,
                      icon: Icons.home,
                      label: 'Home',
                      index: 0,
                      selectedIndex: selectedIndex,
                      ref: ref,
                    ),
                    // Right Side (e.g., Profile)
                    _buildNavItem(
                      context: context,
                      icon: Icons.person,
                      label: 'Profile',
                      index: 2,
                      selectedIndex: selectedIndex,
                      ref: ref,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Center Circular Button
          Positioned(
            bottom:
                -25, // Adjust to control how much it extends beyond the screen
            child: CustomCircularButton(
              icon: Icons.add,
              label: 'New Recipe',
              isSelected: selectedIndex == 1,
              onPressed: () {
                ref.read(selectedIndexProvider.notifier).state = 1;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required WidgetRef ref,
  }) {
    final theme = Theme.of(context);
    final color = selectedIndex == index
        ? theme.primaryColor
        : theme.colorScheme.secondary;

    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        ref.read(selectedIndexProvider.notifier).state = index;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
