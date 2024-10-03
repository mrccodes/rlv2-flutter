import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/app/theme.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_context_provider.dart';
import 'package:rlv2_flutter/features/auth/screens/landing_screen.dart';
import 'package:rlv2_flutter/features/auth/screens/login_screen.dart';
import 'package:rlv2_flutter/features/auth/screens/splash_screen.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_screen.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final userSessionContextState =
        ref.watch(userContextSessionNotifierProvider);

    return MaterialApp(
      theme: MyAppTheme.theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LandingScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) =>
            authState.isLoading // || userSessionContextState.isLoading
                ? const SplashScreen()
                : const DashboardScreen(),
      },
    );
  }
}
