import 'package:rlv2_flutter/features/auth/models/user_model.dart';

class UserWithToken extends User {
  UserWithToken({
    required super.id,
    required super.password,
    required super.email,
    required super.username,
    required super.stripeCustomerId,
    required super.createdAt,
    required super.updatedAt,
    required this.token,
  });
  // Factory method to create UserWithToken from JSON
  factory UserWithToken.fromJson(Map<String, dynamic> json) {
    return UserWithToken(
      id: json['id'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      stripeCustomerId: json['stripeCustomerId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String token;

  // Override toJson method to include the token in the output
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson(); // Get JSON from the base class
    data['token'] = token; // Add the token field
    return data;
  }
}
