// lib/widgets/custom_bottom_navigation_bar.dart

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onMainButtonPressed;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onMainButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Left Side (e.g., Home)
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
            ),

            // Right Side (e.g., Profile)
            _buildNavItem(
              icon: Icons.person,
              label: 'Profile',
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final Color color = selectedIndex == index ? Colors.blue : Colors.grey;

    return MaterialButton(
      minWidth: 40,
      onPressed: () => onItemSelected(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
