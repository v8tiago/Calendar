import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/components/model/event.dart';
import 'package:login/constants.dart';

class EventService {
  Future<Map<String, List<Event>>> fetchEvents(int currentYear) async {
    String path = '${Constants.baseEvents}/$currentYear';
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
        try {
          final response = await http.post(
            Uri.parse(Constants.baseEvents),
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

