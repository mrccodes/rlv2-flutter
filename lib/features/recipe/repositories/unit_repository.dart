import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/recipe/models/unit_model.dart';

class UnitRepository {
  UnitRepository({
    required this.apiService,
  });

  final ApiService apiService;

  Future<List<Unit>> getUnits() async {
    final response = await apiService.getRequest<List<Unit>>(
      '/units',
      (data) => (data as List<dynamic>)
          .map((item) => Unit.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
    return response;
  }
}
