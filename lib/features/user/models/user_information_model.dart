class UserInformation {
  UserInformation({
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.bio,
  });

  factory UserInformation.fromJson(Map<String, String> json) {
    return UserInformation(
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      bio: json['bio'],
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? bio;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'bio': bio,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
