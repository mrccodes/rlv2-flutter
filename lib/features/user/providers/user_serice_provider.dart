import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/providers/user_repository_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository: userRepository);
});
