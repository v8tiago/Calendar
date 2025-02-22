import 'dart:convert';

enum UserRole {
  master,
  basic,
}

class User {
  final String name;
  final String email;
  final UserRole role;

  User({
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: _userRoleFromString(json['role'] ?? 'basic'), // Provide a default value if 'role' is missing
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': _userRoleToString(role),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      role: _userRoleFromString(map['role'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.role == role;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ role.hashCode;
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

  static String _userRoleToString(UserRole role) {
    switch (role) {
      case UserRole.master:
        return 'master';
      case UserRole.basic:
        return 'basic';
      default:
        return 'basic';
    }
  }
}