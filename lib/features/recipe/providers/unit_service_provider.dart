import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/providers/unit_repository_provider.dart';
import 'package:rlv2_flutter/features/recipe/services/unit_service.dart';

final unitServiceProvider = Provider<UnitService>(
  (ref) => UnitService(
    unitRepository: ref.read(unitRepositoryProvider),
  ),
);
