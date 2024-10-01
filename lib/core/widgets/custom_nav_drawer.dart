import 'package:flutter/material.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 100, 16, 10),
            child: Text(
              l10n.menuTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(l10n.accountButton),
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              Navigator.pop(context);
              // Navigate to account screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(l10n.dashboardButton),
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              Navigator.pop(context);
              // Handle dashboard navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(l10n.settingsButton),
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
        ],
      ),
    );
  }
}
