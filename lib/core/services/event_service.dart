import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:magic_calendar/core/model/event.dart';
import 'package:magic_calendar/constants.dart';
import 'package:magic_calendar/core/services/dto/event_request.dart';

class EventService {
  Future<Map<String, List<Event>>> fetchEvents(int currentYear) async {
    String path = '${Constants.baseEvents}/$currentYear';
    final response = await http.get(
      Uri.parse(path),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      Map<String, List<Event>> eventsByDate = {};

      try {
        data.forEach((date, events) {
          eventsByDate[date] = List<Event>.from(
              events.map((eventJson) => Event.fromJson(eventJson)));
        });

        return eventsByDate;
      } catch (e) {
        print('error caught: $e');
        return eventsByDate;
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future addEvent(Event event) async {
      final eventRequest = EventRequest.fromEvent(event);
      final body = eventRequest.toJsonString();
      print('Request Body: $body'); 
    try {
      final response = await http.post(
        Uri.parse(Constants.baseEvents),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // if (response.statusCode == 200) {
      //   return json.decode(response.body);
      // } else {
      //   throw Exception('Failed to add event');
      // }
    } catch (error) {
      log(error.toString());
      throw Exception('Failed to add events');
    }
  }
}
