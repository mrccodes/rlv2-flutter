import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';

RecipeVersionWithData? checkForVersion(
  String? versionId,
  List<RecipeVersionWithData> versions,
) {
  RecipeVersionWithData? version;

  for (final v in versions) {
    if (v.id == versionId) {
      version = v;
    }
  }

  return version;
}
