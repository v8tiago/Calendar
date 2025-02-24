abstract class CalendarEvent {}

class LoadEvents extends CalendarEvent {}

class DeleteCalendarEvent extends CalendarEvent {
  final String eventId;

  DeleteCalendarEvent(this.eventId);
}