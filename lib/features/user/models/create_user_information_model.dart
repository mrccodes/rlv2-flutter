class CreateUserInformationBase {
  CreateUserInformationBase({
    this.firstName,
    this.lastName,
    this.bio,
    this.image,
  });

  factory CreateUserInformationBase.fromJson(Map<String, dynamic> json) {
    return CreateUserInformationBase(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'bio': bio,
    };
  }

  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? image;

  @override
  String toString() {
    return 'CreateUserInformation{'
        'firstName: $firstName, '
        'lastName: $lastName, '
        'bio: $bio, '
        'image: $image}';
  }
}

class CreateUserInformation extends CreateUserInformationBase {
  CreateUserInformation({
    required this.userId,
    super.firstName,
    super.lastName,
    super.bio,
    super.image,
  });

  factory CreateUserInformation.fromJson(Map<String, dynamic> json) {
    return CreateUserInformation(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      ...super.toJson(),
    };
  }

  final String userId;

  @override
  String toString() {
    return 'CreateUserInformation{'
        'userId: $userId, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'bio: $bio, '
        'image: $image}';
  }
}
