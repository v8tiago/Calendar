import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calendar/core/model/event.dart';
import 'package:magic_calendar/core/model/event_type.dart';
import 'package:magic_calendar/constants.dart';
import 'package:magic_calendar/modules/home/components/calendar/cm_calendar_builder.dart';
import 'package:magic_calendar/modules/home/components/calendar/cm_header_style.dart';
import 'package:magic_calendar/shared/presentation/widgets/cm-popup-details.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key, required this.events});
  final Map<String, List<Event>> events;

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    final String dayKey = DateFormat('yyyy-MM-dd').format(day);
    return widget.events[dayKey] ?? List.empty();
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                CmPopupDetails(
                    type: 'Tipo: ', value: event.type.eventTypeDetail),
                SizedBox(height: 15.0),
              ],
              ...[
                CmPopupDetails(type: 'Descrição: ', value: event.description),
                SizedBox(height: 15.0),
              ],
              ...[
                CmPopupDetails(type: 'Local: ', value: event.location),
                SizedBox(height: 15.0),
              ],
              ...[
                CmPopupDetails(
                  type: 'Horário Início: ',
                  value: event.isAllDay
                      ? ''
                      : event.startTime?.format(context) ?? '',
                ),
                SizedBox(height: 8.0),
              ],
              ...[
                CmPopupDetails(
                  type: 'Horário Fim: ',
                  value: event.isAllDay
                      ? ''
                      : event.endTime?.format(context) ?? '',
                ),
                SizedBox(height: 8.0),
              ],
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      //TODO implementar
                    });
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
                TextButton(
                  child: Text(
                    'Fechar',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Event>(
          locale: 'pt_BR',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          headerStyle: CmHeaderStyle(context: context),
          calendarBuilders: CmCalendarBuilder(context: context),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.grey),
            weekdayStyle: TextStyle(color: Colors.black),
          ),
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
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
            DateFormat('EEE, dd \'de\' MMMM', 'pt_BR').format(_selectedDay!),
            style: TextStyle(fontSize: 17, color: Colors.grey[500]),
          ),
        ),
        const SizedBox(height: 15.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event_busy, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        'Nenhum evento para este dia',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  String startTime = value[index].isAllDay
                      ? ''
                      : value[index].startTime?.format(context) ?? '';
                  String endTime = value[index].isAllDay
                      ? ''
                      : value[index].endTime?.format(context) ?? '';
                  bool isAllDay = value[index].isAllDay;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: value[index].type.eventTypeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () => _showEventDetails(context, value[index]),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                                color: Colors.white),
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (isAllDay)
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.white70),
                                const SizedBox(width: 5),
                                const Text("Dia Todo",
                                    style: TextStyle(color: Colors.white)),
                                const SizedBox(width: 10),
                                const Icon(Icons.location_on,
                                    color:
                                        Colors.white70), // Ícone de localização
                                const SizedBox(width: 5),
                                Text(value[index].location,
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )
                          else
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.white70),
                                const SizedBox(width: 5),
                                Text(startTime,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const Text(' - ',
                                    style: TextStyle(color: Colors.white)),
                                Text(endTime,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const SizedBox(width: 10),
                                const Icon(Icons.location_on,
                                    color:
                                        Colors.white70), // Ícone de localização
                                const SizedBox(width: 5),
                                Text(value[index].location,
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
