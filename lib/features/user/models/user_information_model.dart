class UserInformation {
  UserInformation({
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.bio,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String userId;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? bio;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'bio': bio,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'UserInformation{'
        'userId: $userId, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'image: $image, '
        'bio: $bio, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt}';
  }
}
