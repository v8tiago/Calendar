import 'package:flutter/material.dart';
import 'package:magic_calendar/core/model/event.dart';
import 'package:magic_calendar/core/model/user.dart';
import 'package:magic_calendar/core/services/dto/event_request.dart';
import 'package:magic_calendar/core/services/event_service.dart';
import 'package:magic_calendar/modules/home/components/app_bar_home.dart';
import 'package:magic_calendar/modules/home/components/calendar/cm_calendar.dart';
import 'package:magic_calendar/modules/home/events/add_event_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.events, required this.user});

  final Map<String, List<Event>> events;
  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    return Scaffold(
      appBar: AppBarHome(user: widget.user),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 11, 137, 123),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Center(
                    child: Text(
                      "Calendário $currentYear",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    _showAddEventDialog(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: MyCalendar(
              events: widget.events,
              onEventDeleted: _deleteEventFromCalendar,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEventDialog(onAddEvent: (event) async {
            setState(() {
              widget.events[event.date] = [event];
            });
          });
        });
  }

  void _deleteEventFromCalendar(Event event) {
    setState(() {
      widget.events.forEach((key, value) {
        value.removeWhere((e) => e.id == event.id);
      });
      widget.events.removeWhere((key, value) => value.isEmpty);
    });
  }
}
