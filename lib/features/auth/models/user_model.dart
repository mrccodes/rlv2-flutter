class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.stripeCustomerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']! as String,
      username: json['username']! as String,
      email: json['email']! as String,
      password: json['password']! as String,
      stripeCustomerId: json['stripeCustomerId']! as String,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }
  final String id;
  final String username;
  final String email;
  final String password;
  final String stripeCustomerId;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'stripeCustomerId': stripeCustomerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 
    'User{id: $id, '
    'username: $username, '
    'email: $email, '
    'password: $password, '
    'stripeCustomerId: $stripeCustomerId, '
    'createdAt: $createdAt, '
    'updatedAt: $updatedAt}';
  }
}
