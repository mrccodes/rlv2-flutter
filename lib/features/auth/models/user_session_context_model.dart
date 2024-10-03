import 'package:rlv2_flutter/core/models/user_favorite_recipe_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_with_data_model.dart';
import 'package:rlv2_flutter/features/stripe/models/subscription_model.dart';
import 'package:rlv2_flutter/features/auth/models/user_information_model.dart';
import 'package:rlv2_flutter/features/auth/models/user_model.dart';
import 'package:rlv2_flutter/features/auth/models/user_settings_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class UserSessionContext {
  UserSessionContext({
    required this.user,
    required this.userSettings,
    required this.userFavoriteRecipes,
    // required this.organizationUsers,
    required this.userRecipes,
    // required this.subscriptions,
    this.userInformation,
  });

  // Factory method to create a UserSettings from a JSON object
  factory UserSessionContext.fromJson(Map<String, dynamic> json) {
    AppLogger.info('UserSessionContext.fromJson: $json');
    return UserSessionContext(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      userInformation: json['userInformation'] != null
          ? UserInformation.fromJson(
              json['userInformation'] as Map<String, dynamic>,
            )
          : null,
      userSettings: UserSettings.fromJson(
        json['userSettings'] as Map<String, dynamic>,
      ),
      userFavoriteRecipes: (json['userFavoriteRecipes'] as List)
          .map(
            (item) => UserFavoriteRecipe.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      // organizationUsers: (json['organizationUsers'] as List)
      //     .map(
      //       (item) =>
      //           OrganizationUser.fromJson(item as Map<String, dynamic>),
      //     )
      //     .toList(),
      userRecipes: (json['userRecipes'] as List)
          .map(
            (item) => RecipeWithData.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      // subscriptions: (json['subscriptions'] as List)
      //     .map(
      //       (item) =>
      //           Subscription.fromJson(item as Map<String, dynamic>),
      //     )
      //     .toList(),
    );
  }
  final User user;
  final UserInformation? userInformation;
  final UserSettings userSettings;
  final List<UserFavoriteRecipe> userFavoriteRecipes;
  // final List<OrganizationUser> organizationUsers;
  final List<RecipeWithData> userRecipes;
  // final List<Subscription> subscriptions;

  // Method to convert a UserSettings object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'userInformation': userInformation?.toJson(),
      'userSettings': userSettings.toJson(),
      'userFavoriteRecipes':
          userFavoriteRecipes.map((recipe) => recipe.toJson()).toList(),
      // 'organizationUsers': organizationUsers.map((user) => user.toJson()).toList(),
      'userRecipes': userRecipes.map((recipe) => recipe.toJson()).toList(),
      // 'subscriptions': subscriptions.map((subscription) => subscription.toJson()).toList(),
    };
  }
}
