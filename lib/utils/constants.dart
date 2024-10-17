enum OrganizationUserRoles {
  member,
  viewer,
  creator,
  editor,
  admin,
  owner,
}

enum RecipeDifficulty {
  beginner,
  intermediate,
  advanced,
  expert;

  // Add a static method to convert a string to enum
  static RecipeDifficulty fromString(String value) {
    return RecipeDifficulty.values.firstWhere(
      (e) => e.name == value,
      orElse: () =>
          throw ArgumentError('Invalid RecipeDifficulty value: $value'),
    );
  }
}
