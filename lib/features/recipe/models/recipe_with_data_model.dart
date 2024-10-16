import 'package:rlv2_flutter/features/recipe/models/recipe_model.dart';
import 'package:rlv2_flutter/features/recipe/models/recipe_version_with_data_model.dart';

class RecipeWithData extends Recipe {
  RecipeWithData({
    required this.versions,

    // Pass required parameters from the parent class Recipe
    required super.id,
    required super.name,
    required super.author,
    super.createdAt,
    super.updatedAt,
    super.organizationId,
  });

  factory RecipeWithData.fromJson(Map<String, dynamic> json) {
    return RecipeWithData(
      versions: (json['versions'] as List)
          .map(
            (item) =>
                RecipeVersionWithData.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      organizationId: json['organizationId'] as String?,
    );
  }
  
 RecipeVersionWithData? get latestVersion {
  if (versions.isEmpty) {
    return null;
  }
    versions.sort((a, b) => a.versionNumber.compareTo(b.versionNumber));
    return versions.last;
  }


  final List<RecipeVersionWithData> versions;

  @override
  Map<String, dynamic> toJson() {
    return {
      'versions': versions.map((version) => version.toJson()).toList(),
      'id': id,
      'name': name,
      'author': author,
      'organizationId': organizationId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
