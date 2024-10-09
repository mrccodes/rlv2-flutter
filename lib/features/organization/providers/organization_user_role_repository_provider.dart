import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_user_role_repository.dart';

final organizationUserRoleRepositoryProvider = 
  Provider<OrganizationUserRoleRepository>((ref) {
  return OrganizationUserRoleRepository(
    apiService: ref.read(apiServiceProvider),
  );
});