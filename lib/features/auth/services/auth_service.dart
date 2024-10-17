import 'package:rlv2_flutter/features/auth/models/register_model.dart';
import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
import 'package:rlv2_flutter/features/auth/repositories/auth_repository.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_favorite_recipe_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_organizations_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_recipes_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';

class AuthService {
  AuthService({
    required this.authRepository,
    required this.userSettingsNotifier,
    required this.userFavoriteRecipesNotifier,
    required this.userOrganizationsNotifier,
    required this.userRecipesNotifier,
    required this.userInformationNotifier,
  });

  final AuthRepository authRepository;
  final UserSettingsNotifier userSettingsNotifier;
  final UserFavoriteRecipeNotifier userFavoriteRecipesNotifier;
  final UserOrganizationsNotifier userOrganizationsNotifier;
  final UserRecipesNotifier userRecipesNotifier;
  final UserInformationNotifier userInformationNotifier;

  void loadUser(UserSessionContext data) {
    userSettingsNotifier.updateUserSettingsLocal(data.userSettings);
    userFavoriteRecipesNotifier
        .updateUserFavoriteRecipesLocal(data.userFavoriteRecipes);
    userOrganizationsNotifier
        .updateUserOrganzationsLocal(data.userOrganizations);
    userRecipesNotifier.updateUserRecipesLocal(data.userRecipes);

    if (data.userInformation != null) {
      userInformationNotifier.updateUserInformationLocal(data.userInformation!);
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final user = await authRepository.login(email: email, password: password);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(User user) async {
    try {
      await authRepository.logout(user);
      userInformationNotifier.clearUserInformation();
      userSettingsNotifier.clearUserSettings();
      userFavoriteRecipesNotifier.clearUserFavoriteRecipes();
      userOrganizationsNotifier.clearUserOrganizations();
      userRecipesNotifier.clearUserRecipes();
    } catch (e) {
      throw Exception('Error logging out: $e');
    }
  }

  Future<UserSessionContext> register(Register data) async {
    try {
      final user = await authRepository.register(data);
      return user;
    } catch (e) {
      throw Exception('Error creating account: $e');
    }
  }
}
