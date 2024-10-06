import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/user/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService: apiService);
});
