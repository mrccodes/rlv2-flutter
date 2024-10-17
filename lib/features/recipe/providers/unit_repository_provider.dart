import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/recipe/repositories/unit_repository.dart';

final unitRepositoryProvider = Provider<UnitRepository>(
  (ref) => UnitRepository(
    apiService: ref.read(apiServiceProvider),
  ),
);
