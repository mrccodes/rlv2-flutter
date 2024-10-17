import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';

/// Find the latest version of a recipe based on version number
RecipeVersionWithData? findLatestVersion(
  List<RecipeVersionWithData> versions,
) {
  RecipeVersionWithData? latestVersion;

  for (final v in versions) {
    if (latestVersion == null) {
      latestVersion = v;
    } else if (v.versionNumber > latestVersion.versionNumber) {
      latestVersion = v;
    }
  }

  return latestVersion;
}
