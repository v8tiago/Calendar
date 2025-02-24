import 'dart:convert';

import 'package:magic_calendar/constants.dart';
import 'package:magic_calendar/modules/login/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';

class UserRemoteDataSource {
  Future<UserModel?> fetchUser(String email) async {
    String path = '${Constants.baseUser}/login/$email';
    final response = await http.get(Uri.parse(path));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      User user = User.fromMap(jsonResponse);
      return UserModel(email: email, name: user.name, role: user.role);
    }

    return null;
  }
}
