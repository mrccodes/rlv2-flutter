import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_repository.dart';

final organziationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrganizationRepository(apiService: apiService);
});
