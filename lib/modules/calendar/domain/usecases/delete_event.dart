import '../repositories/calendar_repository.dart';

class DeleteEvent {
  final CalendarRepository repository;

  DeleteEvent(this.repository);

  Future<bool> call(String eventId) async {
    return repository.deleteEvent(eventId);
  }
}