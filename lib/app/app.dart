import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/app/theme.dart';
import 'package:rlv2_flutter/features/auth/screens/landing_screen.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_screen.dart';
import 'package:rlv2_flutter/features/theme/theme_model.dart';
import 'package:rlv2_flutter/features/theme/theme_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSettings =
        ref.watch(userSettingsProvider.select((state) => state.data));
    AppLogger.info('ThemeMode: ${userSettings?.preferredMode}');


    return MaterialApp(
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: userSettings != null ? 
        ThemeModeModel.fromString(userSettings.preferredMode)  : 
        ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LandingScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
