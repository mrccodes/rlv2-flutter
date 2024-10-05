import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/theme/theme_model.dart';
import 'package:rlv2_flutter/features/theme/theme_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    
    ref.listen<ThemeModeType>(themeProvider, (previous, next) {
      // When theme changes, patch it to the server
      const userId = 'yourUserId'; // Fetch this from your user session

      AppLogger.info('Saving theme mode $next for user $userId');
    });

    return Column(
      children: [
        SwitchListTile(
          title: const Text('Use System Theme'),
          value: themeNotifier.themeMode == ThemeModeType.system, 
          onChanged: (value) {
            if (value) {
              themeNotifier.themeMode = ThemeModeType.system; 
            }
          },
        ),
        SwitchListTile(
          title: const Text('Use Dark Theme'),
          value: themeMode == ThemeModeType.dark,
          onChanged: themeMode == ThemeModeType.system
              ? null  // Disable when system theme is used
              : (value) {
                  themeNotifier.themeMode = value
                      ? ThemeModeType.dark
                      : ThemeModeType.light;
                },
        ),
      ],
    );
  }
}
