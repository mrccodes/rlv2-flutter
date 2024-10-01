class OrganizationUser {
  OrganizationUser({
    required this.id,
    required this.organizationId,
    required this.userId,
    required this.isOwner,
    required this.username,
    required this.organizationName,
    required this.createdAt,
  });

  factory OrganizationUser.fromJson(Map<String, String> json) {
    return OrganizationUser(
      id: json['id']!,
      organizationId: json['organizationId']!,
      userId: json['userId']!,
      isOwner: json['isOwner']!,
      username: json['username']!,
      organizationName: json['organizationName']!,
      createdAt: json['createdAt']!,
    );
  }
  final String id;
  final String organizationId;
  final String userId;
  final String isOwner;
  final String username;
  final String organizationName;
  final String createdAt;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'isOwner': isOwner,
      'username': username,
      'organizationName': organizationName,
      'createdAt': createdAt,
    };
  }
}
