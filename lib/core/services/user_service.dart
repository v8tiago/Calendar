import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_calendar/constants.dart';
import 'package:magic_calendar/core/model/user.dart';


class UserService {
  Future<User?> fetchUser(String email) async {
    String path = '${Constants.baseUser}/login/$email';
    final response = await http.get(Uri.parse(path));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      User user = User.fromMap(jsonResponse);
      return user;
    } else {
      return null;
    }
  }
}

