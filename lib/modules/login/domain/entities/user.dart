class User {
  final String email;
  final String name;
  final UserRole role;

  User({required this.email, required this.name, required this.role});

    factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      role: _userRoleFromString(map['role'] as String),
    );
  }

  static UserRole _userRoleFromString(String role) {
    switch (role.toLowerCase()) { // Convert to lowercase for case-insensitivity
      case 'master':
        return UserRole.master;
      case 'basic':
        return UserRole.basic;
      default:
        return UserRole.basic;
    }
  }
}

enum UserRole {
  master,
  basic,
}

