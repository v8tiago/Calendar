import '../../domain/entities/event.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_local_datasource.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarLocalDataSource dataSource;

  CalendarRepositoryImpl(this.dataSource);

  @override
  Future<Map<String,List<Event>>> getEvents(DateTime date) async {
    return await dataSource.getEvents(date);
  }

  @override
  Future<bool> deleteEvent(String eventId) async {
    return await dataSource.deleteEvent(eventId);
  }
}