class CreateUser {
  CreateUser({
    required this.email,
    required this.password,
    this.username,
  });

  factory CreateUser.fromJson(Map<String, dynamic> json) {
    return CreateUser(
      email: json['email']! as String,
      password: json['password']! as String,
      username: json['username']! as String,
    );
  }

  final String email;
  final String password;
  final String? username;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }

  @override
  String toString() {
    return 'CreateUser{email: $email, '
        'password: $password, username: $username}';
  }
}
