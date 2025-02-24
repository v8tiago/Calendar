import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/delete_event.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetEvents getEvents;
  final DeleteEvent deleteEvent;

  CalendarBloc(this.getEvents, this.deleteEvent) : super(CalendarInitial()) {
    on<LoadEvents>((event, emit) async {
      emit(CalendarLoading());
      final today = DateTime.now();
      final events = await getEvents(today);
      emit(CalendarLoaded(events));
    });

    on<DeleteCalendarEvent>((event, emit) async {
      await deleteEvent(event.eventId);
      add(LoadEvents());
    });
  }
}