import 'package:rlv2_flutter/features/organization/models/organization_model.dart';

// Use static final, so it's initialized only once and shared across the app
class PersonalRecipesDummyOrg {
  static final Organization instance = Organization(
    id: 'personal_recipes',
    name: 'Personal Recipes',
    owner: 'personal_recipes',
    createdAt: DateTime(2024), // Static date or any fixed value
    updatedAt: DateTime(2024), // Static date or any fixed value
  );
}
