import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_recipes_repository.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class OrganizationRecipesService {
  OrganizationRecipesService({
    required this.organizationRecipesRepository,
  });

  final OrganizationRecipesRepository organizationRecipesRepository;

  Future<List<RecipeWithData>> fetchOrganizationRecipes(
    String organizationId,
  ) async {
    try {
      final response =
          await organizationRecipesRepository.fetchOrganizationRecipes(
        organizationId,
      );
      return response;
    } on ApiException catch (e) {
      AppLogger.error(e.errors.join('\n'));
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
