import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/core/widgets/multi_toggle.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/theme/theme_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);

    final userSettings = ref.watch(userSettingsProvider);

    final lightModeOption = ToggleOption(
      label: ThemeMode.light,
    );
    final darkModeOption = ToggleOption(
      label: ThemeMode.dark,
    );
    final systemModeOption = ToggleOption(
      label: ThemeMode.system,
    );

    if (themeState.isLoading) {
      return const LoadingWidget();
    }
    final options = [lightModeOption, darkModeOption, systemModeOption];
    return MultiToggle(
      options: options,
      label: 'Theme Mode',
      initialOption: options.firstWhere(
        (option) => option.label.name == userSettings.data?.preferredMode,
        orElse: () => systemModeOption,
      ),
      onToggle: (option) async {
        if (authState.user == null) {
          AppLogger.error('User is not authenticated');
          return;
        }

        await ref
            .read(themeProvider.notifier)
            .toggleTheme(authState.user!.id, option);

        AppLogger.info('Toggle changed to option ${option.name}');
      },
    );
  }
}
