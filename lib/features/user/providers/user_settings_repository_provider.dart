import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/user/repositories/user_settings_repository.dart';

final userSettingsRepositoryProvider = Provider<UserSettingsRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserSettingsRepository(apiService: apiService);
});
