import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/recipe/repositories/recipe_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>(
  (ref) {
    final apiService = ref.watch(apiServiceProvider);
    return RecipeRepository(
      apiService: apiService,
    );
  },
);
