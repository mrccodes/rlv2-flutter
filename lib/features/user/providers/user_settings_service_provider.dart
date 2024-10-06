import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_repository_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_settings_service.dart';

final userSettingsServiceProvider = Provider<UserSettingsService>((ref) {
  final userSettingsRepository = ref.watch(userSettingsRepositoryProvider);
  return UserSettingsService(userSettingsRepository: userSettingsRepository);
});
