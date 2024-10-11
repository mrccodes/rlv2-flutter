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
    final themeLoading = ref.watch(
      themeProvider.select((state) => state.isLoading),
    ); 
    final userId = ref.watch(authProvider.select((value) => value.user?.id));

    final userPreferredMode = ref.watch(
      userSettingsProvider.select((value) => value.data?.preferredMode),
    );

    final lightModeOption = ToggleOption(
      label: ThemeMode.light,
    );
    final darkModeOption = ToggleOption(
      label: ThemeMode.dark,
    );
    final systemModeOption = ToggleOption(
      label: ThemeMode.system,
    );

    if (themeLoading) {
      return const LoadingWidget();
    }
    final options = [lightModeOption, darkModeOption, systemModeOption];
    return MultiToggle(
      options: options,
      label: 'Theme Mode',
      initialOption: options.firstWhere(
        (option) => option.label.name == userPreferredMode,
        orElse: () => systemModeOption,
      ),
      onToggle: (option) async {
        await ref
            .read(themeProvider.notifier)
            .toggleTheme(userId, option);

        AppLogger.info('Toggle changed to option ${option.name}');
      },
    );
  }
}
