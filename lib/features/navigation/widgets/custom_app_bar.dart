// lib/core/widgets/app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    required this.scaffoldKey,
    this.showMenuButton = false,
    super.key,
  });

  final String title;
  final bool showMenuButton;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final scaffoldKey = ref.watch(scaffoldKeyProvider);
    final navButtonShowing = Navigator.of(context).canPop();
    final isLandingPage = ModalRoute.of(context)?.settings.name == '/';

    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      titleSpacing: navButtonShowing && !isLandingPage
          ? -15
          : NavigationToolbar.kMiddleSpacing,
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
      actions: showMenuButton
          ? [
              IconButton(
                icon: const Icon(Icons.menu),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
