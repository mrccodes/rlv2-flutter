import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_user_repository.dart';

final organizationUserRepositoryProvider =
    Provider<OrganizationUserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrganizationUserRepository(apiService: apiService);
});
