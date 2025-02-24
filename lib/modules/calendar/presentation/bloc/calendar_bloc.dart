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
      try {
        final events = await getEvents(DateTime.now());
        emit(CalendarLoaded(events: events));
      } catch (e) {
        emit(CalendarError(message: e.toString()));
      }
    });

    on<DeleteCalendarEvent>((event, emit) async {
      try {
        await deleteEvent(event.eventId);
        emit(CalendarInitial()); // Refresh the calendar after deleting
      } catch (e) {
        emit(CalendarError(message: e.toString()));
      }
    });
  }
}