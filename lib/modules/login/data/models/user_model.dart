import 'package:magic_calendar/modules/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.name, required super.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'role': role
    };
  }
}