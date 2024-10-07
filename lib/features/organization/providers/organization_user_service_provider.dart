import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_user_repository_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_user_service.dart';

final organizationUserServiceProvider =
    Provider<OrganizationUserService>((ref) {
  final organizationUserRepository =
      ref.watch(organizationUserRepositoryProvider);
  return OrganizationUserService(
    organizationUserRepository: organizationUserRepository,
  );
});
