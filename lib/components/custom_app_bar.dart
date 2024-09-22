import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  
  const CustomAppBar({
    Key? key,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'lib/assets/icons/logo.png',
            fit: BoxFit.contain,
            height: 48,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(title),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            scaffoldKey.currentState?.openEndDrawer();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
