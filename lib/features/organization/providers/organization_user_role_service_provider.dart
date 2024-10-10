import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_user_role_repository_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_user_role_service.dart';

final organizationUserRoleServiceProvider =
    Provider<OrganizationUserRoleService>((ref) {
  return OrganizationUserRoleService(
    organizationUserRoleRepository:
        ref.read(organizationUserRoleRepositoryProvider),
  );
});
