import '../entities/event.dart';

abstract class CalendarRepository {
  Future<Map<String, List<Event>>> getEvents(DateTime date);
  Future<bool> deleteEvent(String eventId);
}