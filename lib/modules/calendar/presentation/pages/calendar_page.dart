import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_calendar/modules/calendar/presentation/widgets/cm_teste_calendar_builder.dart';
import 'package:magic_calendar/modules/calendar/presentation/widgets/cm_teste_calendar_header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/event.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_event.dart';
import '../bloc/calendar_state.dart';
import '../widgets/event_list_item.dart';
import '../widgets/event_details_dialog.dart';
import '../../../../core/utils/date_utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    BlocProvider.of<CalendarBloc>(context).add(LoadEvents());
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventDetailsDialog(
          event: event,
          onEventDeleted: () {
            BlocProvider.of<CalendarBloc>(context).add(DeleteCalendarEvent(event.id));
          },
        );
      },
    );
  }

  List<Event> _getEventsForDay(DateTime day, Map<String, List<Event>> events) {
    final String dayKey = DateFormat('yyyy-MM-dd').format(day);
    return events[dayKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Calendar')),
    body: BlocBuilder<CalendarBloc, CalendarState>(
    builder: (context, state) {
    if (state is CalendarLoading) {
    return Center(child: CircularProgressIndicator());
    } else if (state is CalendarLoaded) {

          return Column(
            children: [
              TableCalendar<Event>(
                locale: 'pt_BR',
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                headerStyle: CmTesteHeaderStyle(context: context),
                calendarBuilders: CmTesteCalendarBuilders(context: context),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: (day) => _getEventsForDay(day, state.events),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.grey),
                  weekdayStyle: TextStyle(color: Colors.black),
                ),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 15.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  DateFormat('EEE, dd \'de\' MMMM', 'pt_BR')
                      .format(_selectedDay!),
                  style: TextStyle(fontSize: 17, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: _getEventsForDay(_selectedDay!, state.events).isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_busy,
                                size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              'Nenhum evento para este dia',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _getEventsForDay(_selectedDay!, state.events).length,
                        itemBuilder: (context, index) {
                          return EventListItem(
                            event: _getEventsForDay(_selectedDay!, state.events)[index],
                            onTap: () => _showEventDetails(context, _getEventsForDay(_selectedDay!, state.events)[index]),
                          );
                        },
                      ),
              ),
            ],
          );
        }
        return Container(); // Estado inicial ou outros estados
      },
    ),
    );
  }
}