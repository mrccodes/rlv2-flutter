import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/recipe/providers/recipe_repository_provider.dart';
import 'package:rlv2_flutter/features/recipe/services/recipe_service.dart';

final recipeServiceProvider = Provider<RecipeService>(
  (ref) => RecipeService(
    recipeRepository: ref.watch(recipeRepositoryProvider),
  ),
);
