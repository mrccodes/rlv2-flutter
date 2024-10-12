import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/user_session_context_service_provider.dart';
import 'package:rlv2_flutter/features/organization/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_recipes_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

final userSessionListenerProvider = Provider<void>((ref) {
  ref.listen<AuthState>(authProvider, (previous, next) async {
    final previousUserId = previous?.user?.id;
    final nextUserId = next.user?.id;
    final userContextService = ref.read(userSessionContextServiceProvider);

    if (ref.read(userSettingsProvider.notifier).loggedInUserSettings?.userId !=
            null &&
        ref
                .read(userInformationProvider.notifier)
                .loggedInUserInformation
                ?.userId !=
            null) {
      // If the user id already exists the user just registered
      // so app is loaded with fresh account already
      return;
    }

    if (previousUserId != nextUserId && nextUserId != null) {
      // Set loading to true using setters
      ref.read(userInformationProvider.notifier).isLoading = true;
      ref.read(userSettingsProvider.notifier).isLoading = true;
      ref.read(userFavoriteRecipeProvider.notifier).isLoading = true;
      ref.read(userOrganizationsProvider.notifier).isLoading = true;
      ref.read(userRecipesProvider.notifier).isLoading = true;

      try {
        final context =
            await userContextService.fetchUserSessionContext(nextUserId);
        AppLogger.info('TEST TEST TEST TEST\nTEST TEST TEST TEST');
        AppLogger.info('orgUsers: ${context.userOrganizations}');

        // Update data using methods
        ref
            .read(userSettingsProvider.notifier)
            .updateUserSettingsLocal(context.userSettings);
        ref
            .read(userFavoriteRecipeProvider.notifier)
            .updateUserFavoriteRecipesLocal(context.userFavoriteRecipes);
        ref
            .read(userOrganizationsProvider.notifier)
            .updateUserOrganzationsLocal(context.userOrganizations);
        ref
            .read(userRecipesProvider.notifier)
            .updateUserRecipesLocal(context.userRecipes);

        if (context.userInformation != null) {
          ref
              .read(userInformationProvider.notifier)
              .updateUserInformationLocal(context.userInformation!);
        }
      } on ApiException catch (e) {
        AppLogger.error('Error loading user session context: $e');
        AppLogger.error('Errors: ${e.errors.join(', ')}');
        rethrow;
      } catch (e) {
        AppLogger.error('Error loading user session context: $e');
        throw Exception('Error loading user session context: $e');
      } finally {
        // Set loading to false using setters
        ref.read(userInformationProvider.notifier).isLoading = false;
        ref.read(userSettingsProvider.notifier).isLoading = false;
        ref.read(userFavoriteRecipeProvider.notifier).isLoading = false;
        ref.read(userOrganizationsProvider.notifier).isLoading = false;
        ref.read(userRecipesProvider.notifier).isLoading = false;
      }
    } else if (nextUserId == null) {
      // Clear data using methods
      ref.read(userInformationProvider.notifier).clearUserInformation();
      ref.read(userSettingsProvider.notifier).clearUserSettings();
      ref.read(userFavoriteRecipeProvider.notifier).clearUserFavoriteRecipes();
      ref.read(userOrganizationsProvider.notifier).clearUserOrganizations();
      ref.read(userRecipesProvider.notifier).clearUserRecipes();
    }
  });
});
