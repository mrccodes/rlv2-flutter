import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/providers/organzation_repository_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_service.dart';

final organizationServiceProvider = Provider<OrganizationService>((ref) {
  final organizationRepository = ref.watch(organziationRepositoryProvider);
  return OrganizationService(organizationRepository: organizationRepository);
});
