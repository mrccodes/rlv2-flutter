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

  factory OrganizationUser.fromJson(Map<String, dynamic> json) {
    return OrganizationUser(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      userId: json['userId'] as String,
      isOwner: json['isOwner'] as String,
      username: json['username'] as String,
      organizationName: json['organizationName'] as String,
      createdAt: json['createdAt'] as String,
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
