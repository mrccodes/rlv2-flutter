import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/theme/theme_model.dart';
import 'package:rlv2_flutter/features/theme/theme_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final authState = ref.watch(authNotifierProvider);

    if (!authState.isAuthenticated) {
      return const SizedBox.shrink();
    }

    ref.listen<ThemeModeType>(themeProvider, (previous, next) {
      // When theme changes, patch it to the server
      const userId = 'yourUserId'; // Fetch this from your user session

      AppLogger.info('Saving theme mode $next for user $userId');
    });

    void onDarkModeToggle({required bool isDarkMode}) {
      themeNotifier.themeMode =
          isDarkMode ? ThemeModeType.dark : ThemeModeType.light;
    }

    void onSystemModeToggle({required bool isUsingSystemTheme}) {
      themeNotifier.themeMode =
          isUsingSystemTheme ? ThemeModeType.system : ThemeModeType.light;
    }

    if (themeMode == ThemeModeType.system) {
      return Column(
        children: [
          SwitchListTile(
              title: const Text('Use System Theme'),
              value: themeNotifier.themeMode == ThemeModeType.system,
              onChanged: (bool isUsingSystemTheme) {
                onSystemModeToggle(isUsingSystemTheme: isUsingSystemTheme);
              },
            ),
        ],
      );
    } else {
      return Column(
        children: [
          SwitchListTile(
            title: const Text('Use System Theme'),
            value: themeNotifier.themeMode == ThemeModeType.system,
            onChanged: (bool isUsingSystemTheme) {
                onSystemModeToggle(isUsingSystemTheme: isUsingSystemTheme);
              },
          ),
          SwitchListTile(
            title: const Text('Use Dark Theme'),
            value: themeMode == ThemeModeType.dark,
            onChanged: (bool isDarkMode) {
              onDarkModeToggle(isDarkMode: isDarkMode);
            },
          ),
        ],
      );
    }
  }
}
