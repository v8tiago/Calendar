import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_calendar/constants.dart';
import 'package:magic_calendar/modules/calendar/data/models/event_model.dart';

class CalendarLocalDataSource {
  Future<Map<String, List<EventModel>>> getEvents(DateTime date) async {
    final String year = "${date.year}-${date.month}-${date.day}";
    String path = '${Constants.baseEvents}/$year';
    final response = await http.get(
      Uri.parse(path),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      Map<String, List<EventModel>> eventsByDate = {};

      data.forEach((date, events) {
        eventsByDate[date] = List<EventModel>.from(
            events.map((eventJson) => EventModel.fromJson(eventJson)));
      });

      return eventsByDate;
    }
    return {}; // Retorna um mapa vazio em caso de erro ou resposta nula
  }

  Future<List<EventModel>> getEventsInRange(DateTime start, DateTime end) async {
    List<EventModel> result = [];
    DateTime currentDate = start;
    while (!currentDate.isAfter(end)) {
      Map<String, List<EventModel>> eventsMap = await getEvents(currentDate);
      eventsMap.forEach((key, value) => result.addAll(value));
      currentDate = currentDate.add(Duration(days: 1));
    }
    return result;
  }
  
Future<bool> deleteEvent(String eventId) async {
    String path = '${Constants.baseEvents}/$eventId';
    final response = await http.delete(
      Uri.parse(path),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      return true; // Exclusão bem-sucedida
    }
    return false; // Falha na exclusão
  }
}