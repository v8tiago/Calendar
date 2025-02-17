// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/components/model/event.dart';

class EventService {
  static const String _baseUrl = 'https://5f80-177-127-254-59.ngrok-free.app/events/2025'; // Substitua pela URL da sua API

  Future<Map<String, List<Event>>> fetchEvents() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, List<Event>> eventsByDate = {};
      
        data.forEach((date, events) {
          eventsByDate[date] = List<Event>.from(events.map((eventJson) => Event.fromJson(eventJson)));
        });

      return eventsByDate;
    } else {
      throw Exception('Failed to load events');
    }
  }
}
