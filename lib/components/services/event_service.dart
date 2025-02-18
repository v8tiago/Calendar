import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/components/model/event.dart';

class EventService {
  static const String _baseUrl = 'https://72b5-2804-18-50af-659-259c-e46f-9cf6-76f0.ngrok-free.app/api/'; // Substitua pela URL da sua API

  Future<Map<String, List<Event>>> fetchEvents() async {
    String path = _baseUrl + 'events/2025';
    final response = await http.get(Uri.parse(path));

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

  Future<Event> addEvent(Event event) async {
    String path = _baseUrl + 'events';
        try {
          final response = await http.post(
            Uri.parse(path),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'title': event.title,
              'description': event.description,
              'local': event.location,
              'date': event.date,
              'time': event.time,
              'type': jsonEncode(event.type.name.toUpperCase()),
            }),
          );

          if (response.statusCode == 201) {
            return json.decode(response.body);
          } else {
            throw Exception('Failed to add event');
          }
        } catch (error) {
            throw Exception('Failed to add events');
        }
      }
}

