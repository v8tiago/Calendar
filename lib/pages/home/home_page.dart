import 'package:flutter/material.dart';
import 'package:login/components/events/add_event_dialog.dart';
import 'package:login/components/model/event.dart';
import 'package:login/components/myCalendar/my_calendar.dart';
import 'package:login/components/services/event_service.dart';
import 'package:login/pages/home/components/app_bar_home.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/profile_page.dart';
import 'package:login/pages/settings_page.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample(
      {super.key, required this.onThemeChanged, required this.events});

  final Function(String) onThemeChanged;
  final List<Event> events;

  @override
  State<TableBasicsExample> createState() => HomePage();
}

class HomePage extends State<TableBasicsExample> {
  get onThemeChanged => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(onThemeChanged: onThemeChanged),
      body: Column(
        children: [
          MyCalendar(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                final event = widget.events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.date),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
