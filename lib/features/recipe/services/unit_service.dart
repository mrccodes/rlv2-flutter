import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';
import 'package:rlv2_flutter/features/recipe/repositories/unit_repository.dart';

class UnitService {
  UnitService({
    required this.unitRepository,
  });

  final UnitRepository unitRepository;

  Future<List<Unit>> getUnits() async {
    return unitRepository.getUnits();
  }
}
