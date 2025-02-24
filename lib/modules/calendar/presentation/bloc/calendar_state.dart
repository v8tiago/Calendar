import '../../domain/entities/event.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final Map<String, List<Event>> events;

  CalendarLoaded(this.events);
}