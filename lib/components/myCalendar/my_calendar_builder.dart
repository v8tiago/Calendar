import 'package:flutter/material.dart';
import 'package:login/components/model/event.dart';
import 'package:login/components/model/event_type.dart';
import 'package:login/pages/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarBuilder extends CalendarBuilders<Event> {
  const MyCalendarBuilder({required this.context});
  final BuildContext context;

  @override
  Widget? Function(BuildContext, DateTime, List<Event>)? get markerBuilder =>
      (context, date, events) {
        if (events.isEmpty) return SizedBox();
        final uniqueColors = <Color>{};
        for (var event in events) {
          uniqueColors.add(event.type.eventTypeColor);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: uniqueColors.map((color) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              width: 9.0,
              height: 9.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            );
          }).toList(),
        );
      };

  CalendarBuilders<Event> build(BuildContext context) {
    return CalendarBuilders<Event>(
      dowBuilder: (context, day) {
        switch (day.weekday) {
          case DateTime.monday:
            return Center(
                child: Text('Seg',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )));
          case DateTime.tuesday:
            return Center(
                child: Text('Ter',
                    style: TextStyle(
                      color: Colors.black,
                    )));
          case DateTime.wednesday:
            return Center(
                child: Text('Qua',
                    style: TextStyle(
                      color: Colors.black,
                    )));
          case DateTime.thursday:
            return Center(
                child: Text('Qui',
                    style: TextStyle(
                      color: Colors.black,
                    )));
          case DateTime.friday:
            return Center(
                child: Text('Sex',
                    style: TextStyle(
                      color: Colors.black,
                    )));
          case DateTime.saturday:
            return Center(
                child: Text('Sáb',
                    style: TextStyle(
                      color: Colors.grey,
                    )));
          case DateTime.sunday:
            return Center(
                child: Text('Dom',
                    style: TextStyle(
                      color: Colors.grey,
                    )));
          default:
            return Center(
                child: Text('?',
                    style: TextStyle(
                      color: Colors.black,
                    )));
        }
      },
    );
  }
}
