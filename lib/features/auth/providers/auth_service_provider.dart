import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_repository_provider.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_recipes_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';

final authServiceProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthService(
    authRepository: authRepository,
    userRecipesNotifier: ref.watch(userRecipesProvider.notifier),
    userInformationNotifier: ref.watch(userInformationProvider.notifier),
    userSettingsNotifier: ref.watch(userSettingsProvider.notifier),
    userOrganizationsNotifier: ref.watch(userOrganizationsProvider.notifier),
    userFavoriteRecipesNotifier: ref.watch(
      userFavoriteRecipeProvider.notifier,
    ),
  );
});
