// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/components/model/event.dart';

class EventService {
  static const String _baseUrl = 'https://f6a6-2804-2238-73d-a300-5097-bcc2-e200-e8c.ngrok-free.app/events/2025'; // Substitua pela URL da sua API

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
