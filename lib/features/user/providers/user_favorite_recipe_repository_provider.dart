import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/api_service_provider.dart';
import 'package:rlv2_flutter/features/user/repositories/user_favorite_recipe_repository.dart';

final userFavoriteRecipeRepositoryProvider =
    Provider<UserFavoriteRecipeRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserFavoriteRecipeRepository(apiService: apiService);
});
