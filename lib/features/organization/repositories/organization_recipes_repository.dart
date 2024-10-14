import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class OrganizationRecipesRepository {
  OrganizationRecipesRepository({
    required this.apiService,
  });

  final ApiService apiService;
  Future<List<RecipeWithData>> fetchOrganizationRecipes(
    String organizationId,
  ) async {
    try {
      final endpoint = '/organization/$organizationId/recipeWithData';
      final response = await apiService.getRequest<List<RecipeWithData>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => RecipeWithData.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization recipes');
      rethrow;
    }
  }
}
