import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_repository_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_information_service.dart';

final userInformationServiceProvider = Provider<UserInformationService>((ref) {
  final userInformationRepository =
      ref.watch(userInformationRepositoryProvider);
  return UserInformationService(
    userInformationRepository: userInformationRepository,
  );
});
