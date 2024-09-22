import 'package:flutter/material.dart';
import 'package:rlv2_flutter/app/view/theme.dart';
import 'package:rlv2_flutter/dashboard/dashboard_page.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DashboardPage(),
    );
  }
}
