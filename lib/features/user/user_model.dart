class User {

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User from a JSON object
  factory User.fromJson(Map<String, String> json) {
    return User(
      id: json['id']!,
      username: json['username']!,
      email: json['email']!,
      password: json['password']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String id;
  final String username;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
