import '../entities/event.dart';
import '../repositories/calendar_repository.dart';

class GetEvents {
  final CalendarRepository repository;

  GetEvents(this.repository);

  Future<Map<String,List<Event>>> call(DateTime date) async {
    return repository.getEvents(date);
  }
}