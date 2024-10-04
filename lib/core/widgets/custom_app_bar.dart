// lib/core/widgets/app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/scaffold_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldKeyProvider);
    final navButtonShowing = Navigator.of(context).canPop();
    final isLandingPage = ModalRoute.of(context)?.settings.name == '/';
    
    return AppBar(
      titleSpacing: navButtonShowing && !isLandingPage ? 
        -15 : NavigationToolbar.kMiddleSpacing,
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
          color: Theme.of(context).colorScheme.onSecondary,
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
